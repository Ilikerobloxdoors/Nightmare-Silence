--==================================================--
-- NIGHTMARE SILENCE
--==================================================--

--====== Load Entity Spawner ======--

local Spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"
))()

--====== Load Custom Achievements ======--

local CustomAchievements = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/DOORS-Custom-Achievements/main/init.luau"
))()

--====== Services ======--

local Players = game:GetService("Players")
local player = Players.LocalPlayer

--====== Achievement Configuration ======--

local achievementData = {
    Identifier = "EarsClosedMoreNightmares",
    Title = "Ears Closed But More Nightmares",
    Desc = "Be Very Silent And Go hide slowly",
    Reason = "Survive And Encounter Nightmare Silence",
    Image = "rbxassetid://10834675285"
}

local encounterStarted = false
local achievementGranted = false

local function grantAchievement()
    if achievementGranted then
        return
    end

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if not humanoid or humanoid.Health <= 0 then
        warn("Achievement not granted: player is not alive.")
        return
    end

    local success, err = pcall(function()
        CustomAchievements:Grant(achievementData, {
            CheckOwned = true,
            Remember = true
        })
    end)

    if success then
        achievementGranted = true
        print("Achievement grant requested: " .. achievementData.Title)
    else
        warn("Achievement grant failed: " .. tostring(err))
    end
end

--====== Create Entity ======--

local entity = Spawner:Create({
    Entity = {
        Name = "Nightmare Silence",
        Asset = "https://raw.githubusercontent.com/Ilikerobloxdoors/Nightmare-Silence/main/Nightmare%20Silence.rbxm",
        HeightOffset = 0
    },

    Lights = {
        Flicker = {
            Enabled = false,
            Duration = 1
        },
        Shatter = false,
        Repair = false
    },

    Earthquake = {
        Enabled = false
    },

    CameraShake = {
        Enabled = true,
        Range = 100,
        Values = {2.5, 5, 0.1, 0.7}
    },

    Movement = {
        Speed = 125,
        Delay = 3.5,
        Reversed = false
    },

    Rebounding = {
        Enabled = false,
        Type = "Ambush",
        Min = 1,
        Max = 1,
        Delay = 2
    },

    Damage = {
        Enabled = true,
        IgnoreHiding = false,
        Range = 40,
        Amount = 125
    },

    Crucifixion = {
        Type = "Curious",
        Enabled = true,
        Range = 40,
        Resist = false,
        Break = true
    },

    Death = {
        Type = "Curious",
        Hints = {
            "Nightmare Silence",
            "Be Very Silent",
            "Go hide slowly"
        },
        Cause = "Nightmare Silence"
    }
})

--====== Entity Callbacks ======--

entity:SetCallback("OnSpawned", function()
    encounterStarted = true
    print("Nightmare Silence has spawned!")
end)

entity:SetCallback("OnStartMoving", function()
    print("Nightmare Silence has started moving!")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime then
        print("Nightmare Silence entered room: " .. room.Name)
    else
        print("Nightmare Silence entered room again: " .. room.Name)
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
    if lineOfSight then
        print("Player is looking at Nightmare Silence!")
    else
        print("Player's view is obstructed.")
    end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound then
        print("Nightmare Silence started rebounding!")
    else
        print("Nightmare Silence finished rebounding!")
    end
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
    if newHealth <= 0 then
        print("Nightmare Silence killed the player.")
    else
        print("Nightmare Silence damaged the player.")
    end
end)

entity:SetCallback("OnDespawning", function()
    print("Nightmare Silence is despawning!")
end)

entity:SetCallback("OnDespawned", function()
    print("Nightmare Silence has despawned!")

    if encounterStarted then
        grantAchievement()
    end

    encounterStarted = false
end)

--====== Run Entity ======--

entity:Run(true)
