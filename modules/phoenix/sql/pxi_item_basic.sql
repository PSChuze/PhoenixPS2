-- ------------------------------------------------------------
-- Item Basic Changes that require a DAT edit to change
-- ------------------------------------------------------------
-- Item Flags
SET @FLAG_AUG_SENDABLE   =      1; -- 0x00001
SET @FLAG_GM_ONLY        =      2; -- 0x00002
SET @FLAG_MYSTERY_BOX    =      4; -- 0x00004
SET @FLAG_MOG_GARDEN     =      8; -- 0x00008
SET @FLAG_CAN_SEND_ACCT  =     16; -- 0x00010
SET @FLAG_INSCRIBABLE    =     32; -- 0x00020
SET @FLAG_NOAUCTION      =     64; -- 0x00040
SET @FLAG_SCROLL         =    128; -- 0x00080
SET @FLAG_LINKSHELL      =    256; -- 0x00100
SET @FLAG_CANUSE         =    512; -- 0x00200
SET @FLAG_CANTRADENPC    =   1024; -- 0x00400
SET @FLAG_CANEQUIP       =   2048; -- 0x00800
SET @FLAG_NOSALE         =   4096; -- 0x01000
SET @FLAG_NODELIVERY     =   8192; -- 0x02000
SET @FLAG_EX             =  16384; -- 0x04000
SET @FLAG_RARE           =  32768; -- 0x08000
SET @FLAG_NO_RECYCLE     =  65536; -- 0x10000
SET @FLAG_NO_RARE_CHECK  = 131072; -- 0x20000

-- Remove Mail 2 Account for all items
UPDATE `item_basic` SET `flags` = `flags` & ~@FLAG_CAN_SEND_ACCT WHERE `flags` & @FLAG_CAN_SEND_ACCT;

-- Add flags back to certain items
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOSALE | @FLAG_RARE WHERE `itemid` = 120; -- F. Aquarium: add NoSale, Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOSALE | @FLAG_RARE WHERE `itemid` = 121; -- S. Aquarium: add NoSale, Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 582; -- Meteorite: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY | @FLAG_RARE WHERE `itemid` = 613; -- Faded Crystal: add NoAuction, NoDelivery, Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 671; -- Silver Sheet: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX | @FLAG_NOAUCTION | @FLAG_NODELIVERY | @FLAG_RARE WHERE `itemid` = 905; -- Wyvern Skull: add Ex, NoAuction, NoDelivery, Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 950; -- Tahrongi Cactus: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1449; -- T. Whiteshell: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1450; -- L. Jadeshell: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1451; -- R. Stripeshell: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1452; -- O. Bronzepiece: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1453; -- M. Silverpiece: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1454; -- R. Goldpiece: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1455; -- 1 Byne Bill: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1456; -- 100 Byne Bill: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1457; -- 10,000 Byne Bill: add NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX | @FLAG_NOAUCTION | @FLAG_NODELIVERY WHERE `itemid` = 1695; -- Habaneros: add Ex, NoAuction, NoDelivery
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1857; -- Cordial Invite: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1904;   -- Ivory Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1905;   -- Scarlet Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1906;   -- Emerald Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1907;   -- Silver Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1908;   -- Cerulean Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1909;   -- Smalt Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1910;   -- Smoky Chip
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1930; -- Ecarlate Cloth: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1931; -- Argyro Rivet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1932; -- Ut. Gold Thread: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1933; -- Ancient Brass: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1934; -- Benedict Silk: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1935; -- Benedict Yarn: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1936; -- Diabolic Silk: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1937; -- Diabolic Yarn: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1938; -- Rby. Silk Thread: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1939; -- Cardinal Cloth: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1940; -- Supple Skin: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1941; -- Light Filament: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1942; -- Snowy Cermet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1943; -- White Rivet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1944; -- Dark Orichalcum: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1945; -- Black Rivet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1946; -- Smalt Leather: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1947; -- Fetid Lanolin: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1948; -- Coiled Yarn: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1949; -- Brown Doeskin: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1950; -- Chameleon Yarn: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1951; -- Charcoal Cotton: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1952; -- Scarlet Odoshi: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1953; -- Kurogane: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1954; -- Plaited Cord: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1955; -- Ebony Lacquer: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1956; -- Cbl. Myth. Sheet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1957; -- Blue Rivet: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1958; -- Glittering Yarn: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 1959; -- Astral Leather: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1986; -- Orchid Chip  : add Ex
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1987; -- Charcoal Chip: add Ex
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 1988; -- Magenta Chip : add Ex
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX WHERE `itemid` = 2127; -- Metal Chip   : add Ex
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 2207; -- Celerity Salad: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2220; -- Lamian Bone Key: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2223; -- Halv. Brass Key: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2226; -- M. Blackscale Key: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2306; -- Martial Ball Invite: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 2346; -- Tornado Salad: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2366; -- Whistle Coupon: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 2487; -- M. Camp Entry: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 4266; -- Ilm-long Sub: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 4267; -- Btr. Nebimonite: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX | @FLAG_NOAUCTION | @FLAG_NODELIVERY | @FLAG_NOSALE WHERE `itemid` = 4367; -- Batagreens
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 4368; -- 2Leaf Mandra Bud: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_RARE WHERE `itemid` = 5364; -- Tr. Grounds Key: add Rare
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 5647; -- Lik Kabob: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_INSCRIBABLE WHERE `itemid` = 5648; -- Grilled Lik: add Inscribable
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION WHERE `itemid` = 14652; -- Protean Ring: add NoAuction
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_NOAUCTION WHERE `itemid` = 14653; -- Variable Ring: add NoAuction
UPDATE `item_basic` SET `flags` = `flags` | @FLAG_EX | @FLAG_LINKSHELL | @FLAG_NOAUCTION WHERE `itemid` = 19202; -- Smart Grenade: add Ex, Linkshell, NoAuction
