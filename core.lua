-- Config
local COUNT_DOWN_TIMER = 5;

-- Variables
local glootframe = CreateFrame("Frame", "glootframe", UIParent);
local lastupdate = 0;
local updatefrequency = 1;
local inprogress = false;
local currentitemlink = nil;

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

-- Function to handle arguments from the slash command
local function CommandHandler(item)
    if(item ~= nil) then
        local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(item);
        
    end
end

-- Create slash commands
SLASH_GLOOTDIST1 = "/gloot";
SlashCmdList["GLOOTDIST"] = CommandHandler;