Config = {}


Config.Models = {
    'prop_parknmeter_01', -- models that can be robbed
    'prop_parknmeter_02',
}

Config.ModelHashes = {
    -1940238623, -- Hash for prop_parknmeter_01
    2108567945 -- Hash for prop_parknmeter_02
}

Config.Cash = 'cash' -- cash, blackmoney, markedbills, dirtymoney
Config.Payout = {min = 0, max = 100} -- Define a range for payout
Config.Dispatch = 'default' -- default, cd, ps, other

-- If you want a custom alert for ps-dispatch, follow their readme to do so,
-- and then change the export in the main.lua file.
