-- Config
local COUNT_DOWN_TIMER = 5;

-- Variables
local glootframe = CreateFrame("Frame", "glootframe", UIParent);
local lastupdate = 0;
local updatefrequency = 2;
local inprogress = false;
local currentitemlink = nil;
local rolltype = "need";

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
        if(inprogress == true) then
            if(COUNT_DOWN_TIMER == 5) then
                SendChatMessage(string.upper(rolltype) .. " " .. currentitemlink, "RAID_WARNING", "COMMON");
				--print(string.upper(rolltype) .. " " .. currentitemlink);
            end

			SendChatMessage(COUNT_DOWN_TIMER .. ". . .", "RAID", "COMMON");
			
            if(COUNT_DOWN_TIMER <= 0) then
                inprogress = false;
            end
            
            lastupdate = 0;
            COUNT_DOWN_TIMER = COUNT_DOWN_TIMER - 1;
        end
    end
end

-- Register Events and Set Scripts
glootframe:RegisterEvent("PLAYER_ENTERING_WORLD");
glootframe:SetScript("OnEvent", OnEvent);
glootframe:SetScript("OnUpdate", OnUpdate);

-- Function to handle arguments from the slash command
local function CommandHandler(msg)
    if(msg ~= nil) then
        local rtype, item = msg:match("^(%S*)%s*(.-)$");
		if(rtype == nil or item == nil) then
			print("gLootDist: Usage:  /gloot <rolltype> <item link>");
		else
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(item);
			currentitemlink = itemLink;
			inprogress = true;
			COUNT_DOWN_TIMER = 5;
			rolltype = rtype;
		end
    else
		print("gLootDist: Usage:  /gloot <rolltype> <item link>");
	end
end

-- Create slash commands
SLASH_GLOOTDIST1 = "/gloot";
SlashCmdList["GLOOTDIST"] = CommandHandler;