-- Config

-- Variables
local glootframe = CreateFrame("Frame", "glootframe", UIParent);
local lastupdate = 0;
local updatefrequency = 1;

-- Event handling function
local function OnEvent(self, event, ...)
    if(event == "PLAYER_ENTERING_WORLD") then
        glootframe:UnregisterEvent("PLAYER_ENTERING_WORLD");
        print("gLootDist Loaded");
    end
end

-- Update function
local function OnUpdate(self, elapsed)
    lastupdate = lastupdate + elapsed;
    
    if(lastupdate >= updatefrequency) then
        lastupdate = 0;
    end
    
end

-- Register Events and Set Scripts
glootframe:RegisterEvent("PLAYER_ENTERING_WORLD");
glootframe:SetScript("OnEvent", OnEvent);
glootframe:SetScript("OnUpdate", OnUpdate);