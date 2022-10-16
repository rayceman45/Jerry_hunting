-- Credit FB : Jaturong Wandee --
-- Discord : Jerry#4051 --

Config = {}

--------------------------- [เกี่ยวกับสัตว์] ---------------------------

Config.Base                 = '1.2'    -- 1.1 / 1.2 เลือก Base ว่าคุณใช้ Base ไหนอยู่

Config.SpawnAnimalNumber    = 9        -- จำนวนสัตว์ที่จะ Spawn (กำหนดเองได้)
Config.PNearAnimalToEscape  = 20       -- ระยะห่างระหว่างผู้เล่นกับสัตว์ ถ้าเข้าใกล้ในระยะที่กำหนด สัตว์จะวิ่งหนี (แนะนำ 20)

Config.TimeToHarvest        = 5000     -- ระยะเวลาในการเก็บ 1000 = 1 วิ | 10000 = 10 วิ
Config.NeedHarvest          = true     -- ต้องการใช้อาวุธในการเก็บหรือไม้ True = ใช้ | False = ไม่ใช้
Config.KnifesForHarvest     = {        -- กำหนดอาวุธที่ใช้ในการเก็บ (https://wiki.rage.mp/index.php?title=Weapons) <--หาได้จากเว็บไซต์นี้
    'WEAPON_KNIFE', 
    'WEAPON_SWITCHBLADE', 
    'WEAPON_MACHETE',
    'WEAPON_MUSKET',
    'WEAPON_DAGGER'
}

Config.WeaponRemoveO        = true              -- ลบปืนเมื่อออกจากระยะที่กำหนด True = เปิด | False = ปิด
Config.RadiousWeaponremove  = 2000              -- กำหนดระยะ เมื่อออกจากระยะจะทำการลบอาวุธ
Config.Weaponremove         = 'WEAPON_MUSKET'   -- กำหนดอาวุธที่จะให้ลบเมื่อออกจากโซน (https://wiki.rage.mp/index.php?title=Weapons) <--หาได้จากเว็บไซต์นี้

Config.HuntPoint = {      -- กำพิกัดล่าสัตว์   
    Pos = {
        x = 4853.41, 
        y = -5656.29, 
        z = 22.45
    }
}

Config.HuntRadious   = 110          -- เมื่อเข้าในระยะนี้ จะทำการ Spawn สัตว์ | เมื่อสัตว์ออกจากระยะนี้ จะทำการลบสัตว์ (ถ้าอยู่ในโซนนี้ผู้เล่นไม่สามารถฆ่ากันได้ เชื่อโยงกับ Config.DisableCombatPlayer)
Config.DisableCombatPlayer = true   -- true = ทำให้ผู้เล่นฆ่ากันไม่ได้ | false = ทำให้ผู้เล่นฆ่ากันได้ปกติ
Config.AntifirWeapon = 'WEAPON_MUSKET'  -- กำหนดอาวุธ ถ้าถืออาวุธชิ้นนี้ จะไม่สามารถยิงคนรอบข้างได้


Config["spawnrandomX"] = {-50, 50}  -- พิกัด(ระยะห่าง) spawn ped x
Config["spawnrandomY"] = {-50, 50}  -- พิกัด(ระยะห่าง) spawn ped y

Config.Animals = {
    Animal1 = {   
        model = "a_c_deer",         -- Model สัตว์    (https://forge.plebmasters.de/peds) <--หาได้จากเว็บไซต์นี้
        hash = -664053099,          -- Hash สัตว์     (https://forge.plebmasters.de/peds) <--หาได้จากเว็บไซต์นี้
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal2 = {   
        model = "a_c_deer",         -- Model สัตว์
        hash = -664053099,          -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal3 = {   
        model = "a_c_deer",         -- Model สัตว์
        hash = -664053099,          -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal4 = {   
        model = "a_c_deer",         -- Model สัตว์
        hash = -664053099,          -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal5 = {   
        model = "a_c_deer",       -- Model สัตว์
        hash = -664053099,        -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal6 = {   
        model = "a_c_deer",      -- Model สัตว์
        hash = -664053099,       -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal7 = {   
        model = "a_c_deer",     -- Model สัตว์
        hash = -664053099,      -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },
    Animal8 = {   
        model = "a_c_deer",     -- Model สัตว์
        hash = -664053099,      -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "water",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",        -- ไอเทมโบนัส 
                    bonuscount = {1, 4},        -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100         -- % การดรอปของไอเทมโบนัส
                }
            }
        }    
    },

    Animal9 = {
        model = "a_c_mtlion",   -- Model สัตว์
        hash = 307287994,       -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "bread",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",       -- ไอเทมโบนัส 
                    bonuscount = {1, 4},       -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100        -- % การดรอปของไอเทมโบนัส
                }
            }
        }  
    }

    --[[Animal10 = {
        model = "a_c_mtlion",   -- Model สัตว์
        hash = 307287994,       -- Hash สัตว์
        items = { -- เกี่ยวกับไอเทม
            itemname = "bread",         -- ไอเทมที่ดรอป
            itemcount = {1, 4},         -- จำนวนไอเทมที่ดรอป
            itemdroprate = 100,         -- % การดรอปของไอเทม

            bonus = {
                {
                    itembonus = "bread",       -- ไอเทมโบนัส 
                    bonuscount = {1, 4},       -- จำนวนไอเทมโบนัส
                    bonusdroprate = 100        -- % การดรอปของไอเทมโบนัส
                }
            }
        }  
    }]]
}


Config.BlipsO = true -- Blip พื่นที่ล่าสัตว์ True = เปิด | False = ปิด
Config.Blips = {
    {
        coords = vector3(4853.41, -5656.29, 22.45), -- กำหนดจุด ที่จะแสดง Blip 
        name = '<font face="font4thai">เขตล่าสัตว์</font>', -- กำหนดชื่อของ Blip
        sprite = 442,   -- กำหนดรูปแบบของ Blip    (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        colour = 6,     -- กำหนดสีของ Blip     (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        scale = 0.8     -- กำหนดขนาดของ Blip
    }
}

Config.BlipOnEntity = true  -- Blip ของสัตว์ True = เปิด | False = ปิด
Config.BlipsAnimals = {
    {
        name = '<font face="font4thai">สัตว์</font>', -- กำหนดชื่อของ Blip
        sprite = 442,   -- กำหนดรูปแบบของ Blip    (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        colour = 1,     -- กำหนดสีของ Blip    (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        scale = 0.8     -- กำหนดขนาดของ Blip
    }
}

--------------------------- [ร้านค้า] ---------------------------

Config.VehicleSpawnLocation = vector3(4983.84, -5145.63, 3)
Config.VehicleSpawnLocationh = 183.47

Config.ShopBlipsO = true -- Blip ร้านค้า True = เปิด | False = ปิด
Config.ShopBlips = {
    shop = {
        coords = vector3(4999.27, -5164.98, 2.76), -- กำหนดจุด ที่จะแสดง Blip 
        name = '<font face="font4thai">ร้านค้าล่าสัตว์</font>', -- กำหนดชื่อของ Blip
        sprite = 432,   -- กำหนดรูปแบบของ Blip    (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        colour = 1,     -- กำหนดสีของ Blip    (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
        scale = 0.8     -- กำหนดขนาดของ Blip
    }
}

Config.ShopMarkerO = true   -- Marker ร้านค้า True = เปิด | False = ปิด
Config.ShopMarker = {
    SM = {
        Pos = { x = 4999.27, y = -5164.98, z = 2.76 }, -- กำหนดพื้นที่ที่จะแสดงของ Marker
        Size  = {x = 0.8, y = 0.8, z = 0.8}, -- กำหนดขนาด Marker
		Colour = {r = 2, g = 5, b = 233},  -- กำหนดสีของ Marker
		Marker = 21 -- กำหนด Marker  (https://docs.fivem.net/docs/game-references/blips/) <--หาได้จากเว็บไซต์นี้
    }
}
Config.MarkerDistance = 25  -- กำหนดระยะ (เมื่อเข้าระยะนี้จะแสดง Marker)

Config.NPCO = true   -- NPC ยืนร้านค้า True = เปิด | False = ปิด
Config.NPC = {
    NPC = {--1
        coords = vector3(4999.9, -5164.68, 2.76), -- กำหนดจุด NPC
        NPC = {
			Model = "U_M_Y_SmugMech_01",    -- Model ของ NPC จะใส่เป็น (https://forge.plebmasters.de/peds) <--หาได้จากเว็บไซต์นี้
			heading = 115.00,	-- จะให้ NPC หันไปทางไหน
			Animation = { -- ใส่ท่าทางให้ NPC
				Scenario = false,
				AnimationDirect = "anim@amb@nightclub@peds@",
				AnimationScene = "rcmme_amanda1_stand_loop_cop",
			},
		},
    }
}


Config.Vehicle = {
    VehicleModel = "manchez2",  --กำหนดรถ ที่จะเช่า (https://wiki.rage.mp/index.php?title=Vehicles) <--หาได้จากเว็บไซต์นี้
    VehiclePrice = 1000 --กำหนดราคารถ ที่จะเช่า
}

Config.Weapon = {
    Weapon = "WEAPON_MUSKET",   --กำหนดอาวุธ ที่จะเช่า (https://wiki.rage.mp/index.php?title=Weapons) <--หาได้จากเว็บไซต์นี้
    Ammo = 50,  --กำหนดกระสุน
    WeaponPrice = 1500  --กำหนดราคาอาวุธ ที่จะเช่า
}


--------------------------- [การแจ้งเตือน] ---------------------------

Config.Text = { -- การแจ้งเตือนข้อความต่างๆ
    -- [เกี่ยวกับสัตว์]
    ['before_harvest']      = 'กด [~g~E~w~] เพื่อเก็บเกี่ยว',
	['harvesting']          = 'กำลังเก็บเนื้อ...',
    ['need_knife']          = 'คุณต้องถืออาวุธก่อน',
    ['you_didnt_kill_it']   = "คุณไม่ได้ฆ่าสัตว์",
    ['remove_weapon']       = 'ระบบได้ทำการลบปืนออกจากตัว!',

    -- [ไอเท็ม]
    ['item_limit']          = 'ไอเทมของคุณเต็ม !',
    ['item_bonus_limit']    = 'ไอเทมโบนัสของคุณเต็ม !',
    ['item_bonus_weight']   = 'น้ำหนักของคุณเต็ม !',
    
    -- [ร้านค้า]
    ['spawn_vehicle']       = 'เช่ารถสำเร็จ',
    ['rent_weapon']         = 'เช่าปืนเรียบร้อยแล้ว'
}
