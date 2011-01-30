-- Config
local COUNT_DOWN_TIMER = 5;

-- Variables
local glootframe = CreateFrame("Frame", "glootframe", UIParent);
local lastupdate = 0;
local updatefrequency = 2;
local inprogress = false;
local currentitemlink = nil;
local rolltype = nil;
local countdown = 0;

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
    
	if(inprogress == true) then
		if(lastupdate >= updatefrequency) then  
            if(countdown == 5) then
				if(IsRaidLeader() == 1 or IsRaidOfficer() == 1) then
					SendChatMessage(string.upper(rolltype) .. " " .. currentitemlink, "RAID_WARNING", "COMMON");
				else
					SendChatMessage(string.upper(rolltype) .. " " .. currentitemlink, "RAID", "COMMON");
				end
            end

			SendChatMessage(countdown .. ". . .", "RAID", "COMMON");
			
            if(countdown <= 0) then
                inprogress = false;
            end
            
            lastupdate = 0;
            countdown = countdown - 1;
        end
    end
end

-- Register Events and Set Scripts
glootframe:RegisterEvent("PLAYER_ENTERING_WORLD");
glootframe:SetScript("OnEvent", OnEvent);
glootframe:SetScript("OnUpdate", OnUpdate);

-- Function to handle slash command
local function CommandHandler(msg)
	local rtype, item = msg:match("^(%S*)%s*(.-)$");
	
	if(rtype == "" or rtype == "help") then
		print("|cfffff000gLootDist:|r Usage:  /gloot |cffff2b4e<rolltype>|r |cffa335ee<item link>|r");
	else
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(item);
		rolltype = rtype;
		currentitemlink = itemLink;
		inprogress = true;
		countdown = COUNT_DOWN_TIMER;
	end
end

-- Create slash commands
SLASH_GLOOTDIST1 = "/gloot";
SlashCmdList["GLOOTDIST"] = CommandHandler;