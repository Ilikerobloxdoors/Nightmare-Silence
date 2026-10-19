local Creator = loadstring(game:HttpGet(
    "https://pastebin.com/raw/0fSnvfGt"
))()

local Workspace = game:GetService("Workspace")

--// Silence Configuration
local entity = Creator.createEntity({
    CustomName = "Silence",

    Model = "https://github.com/Ilikerobloxdoors/Nightmare-Silence/blob/main/Nightmare%20Silence.rbxm",

    Speed = 100,
    DelayTime = 0,
    HeightOffset = 0,

    CanKill = true,
    KillRange = 40,
    BreakLights = true,
    BackwardsMovement = false,

    FlickerLights = {
        false,
        1,
    },

    Cycles = {
        Min = 1,
        Max = 1,
        WaitTime = 1,
    },

    CamShake = {
        true,
        {12.5, 20, 0.1, 1},
        100,
    },

    Jumpscare = {
        true,
        {
            Image1 = "rbxassetid://11535704098",
            Image2 = "rbxassetid://11535704098",

            Shake = true,

            Sound1 = {
                116282238939992,
                {Volume = 1},
            },

            Sound2 = {
                116282238939992,
                {Volume = 1},
            },

            Flashing = {
                true,
                Color3.fromRGB(91, 0, 121),
            },

            Tease = {
                false,
                Min = 4,
                Max = 4,
            },
        },
    },

    CustomDialog = {
        "You died to Silence...",
    },
})

--// Debug Callbacks
entity.Debug.OnEntitySpawned = function(entityTable)
    print("Silence has spawned:", entityTable.Model)
end

entity.Debug.OnEntityDespawned = function(entityTable)
    print("Silence has despawned:", entityTable.Model)
end

entity.Debug.OnEntityStartMoving = function(entityTable)
    print("Silence has started moving!")
end

entity.Debug.OnEntityFinishedRebound = function(entityTable)
    print("Silence has finished rebounding!")
end

entity.Debug.OnEntityEnteredRoom = function(entityTable, room)
    print("Silence entered room:", room)
end

entity.Debug.OnLookAtEntity = function(entityTable)
    print("A player looked at Silence!")
end

entity.Debug.OnDeath = function(entityTable)
    warn("A player died to Silence!")
end

--// Break all currently loaded room lights
local rooms = Workspace:FindFirstChild("CurrentRooms")

if rooms then
    for _, room in ipairs(rooms:GetChildren()) do
        for _, obj in ipairs(room:GetDescendants()) do
            if obj:IsA("PointLight")
                or obj:IsA("SpotLight")
                or obj:IsA("SurfaceLight") then

                obj:Destroy()
            end
        end
    end
end

print("All currently loaded room lights have been broken!")

--// Wait, then spawn Silence
task.wait(1.7)

Creator.runEntity(entity)
