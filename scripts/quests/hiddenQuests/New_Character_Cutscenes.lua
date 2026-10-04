-----------------------------------
-- New Character Cutscenes
-----------------------------------
local quest = HiddenQuest:new('newCharacterCS')

quest.reward = {}

-- Note:
-- Some areas swap order of when you get the Adventurer's coupon and the marker help text.
-- On retail, even if your inventory is full and change nations, the starting cutscene will attempt to give you the Adventurer's coupon and report your inventory is full.
quest.sections =
{
    {
        check = function(player, questVars, vars)
            return quest:getVar(player, 'notSeen') == 1 and xi.settings.main.NEW_CHARACTER_CUTSCENE == 1
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    -- Second part, after the zone that follows event 0
                    if quest:getVar(player, 'part2') == 1 then
                        return { 7, -1, cutsceneFlags }
                    end

                    player:setPos(-280, -12, -90, 0)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    return { 0, -1, cutsceneFlags } -- CS 0 is not a typo.
                end
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    -- Event 0x00 fades your screen to black and waits for another event, otherwise it never fades back in.
                    -- Retail zones you here and plays event 7 on the zone-in. Starting event 7 in place works on today's
                    -- PC client, but the console clients hang in it: they need the zone load first.
                    quest:setVar(player, 'part2', 1)
                    player:setPos(-280, -12, -90, 0, xi.zone.BASTOK_MARKETS)
                end,

                [7] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    quest:setVar(player, 'notSeen', 0)
                    quest:setVar(player, 'part2', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.BASTOK, true))
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(-45, -0, 25, 192)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )
                    return { 1, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.BASTOK, true))
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(134, 8.5, -11, 96)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )
                    return { 1, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.BASTOK, true))
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(0, 0, -12, 192)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    return { 535, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [535] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.SANDORIA, true))
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(-100, 1, -40, 224) --cs exit
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    return { 503, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [503] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.SANDORIA, true))
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(-100, -8, -125, 224)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    return { 500, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.SANDORIA, true))
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- The HP position is slightly different than the CS exit.
                    if quest:getVar(player, 'nations') == 0 then
                        player:setPos(-40.0, -5, 100, 64)
                        player:setHomePoint()
                    end

                    player:setPos(-40.611, -5, 102.5, 57) -- Move back to CS exit position

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.NO_NPCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    return { 531, -1, cutsceneFlags }
                end
            },

            onEventUpdate =
            {
                [531] = function(player, csid, option, npc)
                    -- param 7 is checked in the event according to decomp, but it was never set on Hume F starting a new character.
                    -- param 7 was 0x20012 on a galka changing nations.
                    player:updateEvent({ [7] = 0 })
                end,
            },

            onEventFinish =
            {
                [531] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.WINDURST, true))
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    player:setPos(30, 2, -40, 128)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setHomePoint()
                    end

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.NO_NPCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )
                    return { 367, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [367] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.WINDURST, true))
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'nations') == 0 then
                        player:setPos(-120, -5.5, 175, 48)
                        player:setHomePoint()
                    end

                    player:setPos(-140, -7, 172, 32)

                    local cutsceneFlags = bit.bor(
                        xi.cutsceneFlag.RESET_CAMERA,
                        xi.cutsceneFlag.NO_PCS,
                        xi.cutsceneFlag.OPENING_MODE
                    )

                    return { 305, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [305] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.item.ADVENTURER_COUPON)

                    quest:setVar(player, 'notSeen', 0)
                    local nationsSeen = quest:getVar(player, 'nations')
                    quest:setVar(player, 'nations', utils.mask.setBit(nationsSeen, xi.nation.WINDURST, true))
                end,
            },
        },
    },
}
return quest
