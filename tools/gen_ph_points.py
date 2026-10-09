"""Generate modules/phoenix/data/ph_spawn_points: pin lottery placeholders back to the
fixed spawn points they had before upstream moved mob placement to roam regions.

Run from the lsb-server root:  python tools/gen_ph_points.py modules/phoenix/data/ph_spawn_points <old_mob_spawn_points.sql>
The old SQL comes from: git show 3b73f021e44^:sql/mob_spawn_points.sql
"""
import collections
import glob
import os
import re
import sys

import yaml

Loader = getattr(yaml, 'CSafeLoader', yaml.SafeLoader)

outdir, oldsql = sys.argv[1], sys.argv[2]


def norm(s):
    return re.sub(r'[^a-z0-9]', '', s.lower())


old = {}
rx = re.compile(r"VALUES \((\d+),\d+,'([^']*)','(?:[^'\\]|\\.)*',\d+,\d+,\d+,(-?[\d.]+),(-?[\d.]+),(-?[\d.]+),(\d+),")
for line in open(oldsql, encoding='utf-8', errors='ignore'):
    m = rx.search(line)
    if m:
        old[int(m.group(1))] = (m.group(2), float(m.group(3)), float(m.group(4)), float(m.group(5)), int(m.group(6)))

# spawns any loaded data module already places (phoenix/era layouts win)
module_placed = set()
for f in glob.glob('modules/*/data/**/mobs.yaml', recursive=True):
    if 'ph_spawn_points' in f.replace(os.sep, '/'):
        continue  # our own output from a previous run
    doc = yaml.load(open(f, encoding='utf-8'), Loader=Loader) or {}
    for sid, s in (doc.get('spawns') or {}).items():
        if isinstance(s, dict) and ('region' in s or 'at' in s or 'path' in s or 'circuit' in s):
            module_placed.add(int(sid))

datadirs = {norm(os.path.basename(d)): d for d in glob.glob('data/zones/*')}
written = 0
skipped = collections.Counter()

for zdir in sorted(glob.glob('scripts/zones/*')):
    zname = os.path.basename(zdir)
    ddir = datadirs.get(norm(zname))
    if not ddir or not os.path.exists(os.path.join(ddir, 'mobs.yaml')):
        continue

    ids_lua = os.path.join(zdir, 'IDs.lua')
    ids = open(ids_lua, encoding='utf-8', errors='ignore').read() if os.path.exists(ids_lua) else ''
    doc = yaml.load(open(os.path.join(ddir, 'mobs.yaml'), encoding='utf-8'), Loader=Loader)
    spawns = doc.get('spawns') or {}

    byscript = collections.defaultdict(list)
    for sid, s in sorted(spawns.items()):
        byscript[s.get('script') or s.get('template')].append(sid)

    idmap = {}
    for m in re.finditer(r"(\w+)\s*=\s*GetFirstID\('([^']+)'\)", ids):
        idmap[m.group(1)] = byscript.get(m.group(2), [])[:1]
    for m in re.finditer(r"(\w+)\s*=\s*GetTableOfIDs\('([^']+)'\)", ids):
        idmap[m.group(1)] = byscript.get(m.group(2), [])

    entries = {}
    for f in sorted(glob.glob(os.path.join(zdir, 'mobs', '*.lua'))):
        text = open(f, encoding='utf-8', errors='ignore').read()
        block = re.search(r'phList\s*=\s*\{(.*?)\n\}', text, re.S)
        if not block:
            continue
        nm = os.path.basename(f)[:-4]
        phs = []
        for e in re.finditer(r'\[\s*ID\.mob\.(\w+)(?:\[(\d+)\])?\s*([+-])\s*(\d+)\s*\]', block.group(1)):
            lst = idmap.get(e.group(1)) or []
            idx = int(e.group(2) or 1) - 1
            if idx < len(lst):
                off = int(e.group(4))
                phs.append(lst[idx] + (off if e.group(3) == '+' else -off))
        phs += [int(x) for x in re.findall(r'\[\s*(\d{8})\s*\]', block.group(1))]

        for ph in phs:
            s = spawns.get(ph)
            if not s or not s.get('region'):
                skipped['not a region spawn'] += 1
                continue
            if ph in module_placed:
                skipped['placed by a data module'] += 1
                continue
            o = old.get(ph)
            if not o or (abs(o[1]) <= 1.0 and abs(o[2]) <= 1.0 and abs(o[3]) <= 1.0):
                skipped['no usable old position'] += 1
                continue
            entries[ph] = (nm.replace('_', ' '), o)

    if not entries:
        continue

    zout = os.path.join(outdir, 'zones', os.path.basename(ddir))
    os.makedirs(zout, exist_ok=True)
    with open(os.path.join(zout, 'mobs.yaml'), 'w', encoding='utf-8', newline='\n') as out:
        out.write('# Lottery placeholders on the fixed spawn points they had before roam regions.\n')
        out.write('# Generated from sql/mob_spawn_points.sql at 3b73f021e44^. Do not edit by hand.\n\n')
        out.write('spawns:\n')
        for ph in sorted(entries):
            nm, (_, x, y, z, rot) = entries[ph]
            out.write(f'\n  {ph}: # {nm} placeholder\n')
            out.write('    region: null\n')
            out.write(f'    at:     [{x:.3f}, {y:.3f}, {z:.3f}, {rot}]\n')
            written += 1

print('placeholders pinned:', written)
for k, v in skipped.items():
    print('skipped', k, v)
