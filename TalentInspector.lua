--[[ 
    TalentInspector
	
	by: Rehgar - GG @ Elysium
	
	site: getgood.pro

]]--

local TIFrame = CreateFrame("FRAME", "FooAddonFrame");


local ownName = UnitName("player");

local timeResponseSent = GetTime();

local requestedName = "";
local requestedClass = "";
local storedRequestedName = " ";
local storedRecievedTalents = {};
local currTab = 1;

local CHAT_END = "|r"
local COLOUR_CHAT = "|c8066ff99"
local COLOUR_CHAT_WHITE = "|c80FFFFFF"


local function TalentI_OnEvent()
	local typeResponse = "";
    if arg1 == "TI" and ownName ~= arg4 then
	    local timeNow = GetTime();
		typeResponse, dataResponse = TalentI_strsplit(" ", arg2, 1);
	    if arg2 == "request " .. ownName and (timeNow - timeResponseSent) > 1 then
			timeResponseSent = GetTime();
			local talents = TalentI_UpdateTalents();
			if talents then
			    if arg3 == "GUILD" then
			        SendAddonMessage( "TI", "response " .. talents, "GUILD" );
				elseif (arg3 == "RAID" or arg3 == "PARTY") then
			        SendAddonMessage( "TI", "response " .. talents, "RAID" );				
				end
			end
		elseif typeResponse == "response" and requestedName == arg4 then
			storedRequestedName = requestedName;
			requestedName = "";
			TalentI_SortResponse(dataResponse);		
		end
	end
end

function TalentI_CloseWindow()
    TalentWindowFrame:Hide();
end

function TalentI_UpdateTalents()
    local transferRanks = {};
	local transferString = "";
    for i = 1, 3, 1 do
	    local numTalentTab = GetNumTalents(i);
	    for n = 1, numTalentTab, 1 do
		    nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(i,n);
	        table.insert(transferRanks, currRank);  
		end
	end
	for y = 1, table.getn(transferRanks), 1 do
	    transferString = transferString .. transferRanks[y];
	end
	return transferString;
end

function TalentI_RegisterEvents(unregister)
	local eventpacket = {"CHAT_MSG_ADDON"};

	local i = 1;

	while (eventpacket[i]) do

		if (unregister) then
			TIFrame:UnregisterEvent(eventpacket[i]);
		else
			TIFrame:RegisterEvent(eventpacket[i]);
		end

		i = i + 1;
	end
end

USER_DROPDOWNBUTTONS = {};
function TalentI_addDropDownMenuButton(uid, dropdown, index, title, usable, onClick, hint)
	tinsert(UnitPopupMenus[dropdown],index,uid);
	if hint then
		UnitPopupButtons[uid] = { text = title, dist = 0, tooltip = hint};
	else
		UnitPopupButtons[uid] = { text = title, dist = 0 };
	end
	
	USER_DROPDOWNBUTTONS[uid] = { func = onClick, enabled = usable };
end

function TalentI_Inspect()
	local frame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	local targetGuildName, targetGuildRankName, targetGuildRankIndex = GetGuildInfo("target");
	local ownGuildName, ownGuildRankName, ownGuildRankIndex = GetGuildInfo("player");
	if (UnitInParty("target") or UnitInRaid("target")) then
	    SendAddonMessage( "TI", "request " .. UnitName(frame.unit), "RAID" );	
	elseif targetGuildName == ownGuildName then
	    SendAddonMessage( "TI", "request " .. UnitName(frame.unit), "GUILD" );
	else
	    DEFAULT_CHAT_FRAME:AddMessage(UnitName(frame.unit) .. " cannot be talent inspected as they are not in your group/raid or guild.");
	end
	requestedName = UnitName(frame.unit);
	requestedClass = UnitClass(frame.unit);
end

function TalentI_SortResponse(response)
    local recievedTalents = {};
    for i = 1, string.len(response), 1 do
	    local c = string.sub(response, i, i);
	    table.insert(recievedTalents, c);
	end
	storedRecievedTalents = recievedTalents;
	TalentI_createTalentWindow(recievedTalents);
end

function TalentI_ChangeTab(tab)
    if tab == "1" then
        currTab = 1;	
		TalentI_createTalentWindow(storedRecievedTalents);
	elseif tab == "2" then
        currTab = 2;
        TalentI_createTalentWindow(storedRecievedTalents);		
	elseif tab == "3" then
        currTab = 3;	
		TalentI_createTalentWindow(storedRecievedTalents);
	end
end

function TalentI_strsplit (sep, str)
	    local result = {}
	    for w in string.gfind(str, "([^"..sep.."]+)"..sep.."?") do
		    table.insert(result, w)
	    end
	    return unpack(result)

end

-- Massive function ahead, travel with care
function TalentI_createTalentWindow(talents)


    local tab1Talents = {};
    local tab2Talents = {};
    local tab3Talents = {};
	
	TalentI_Talent0tip:Hide();
	TalentI_Talent1tip:Hide();
	TalentI_Talent2tip:Hide();
	TalentI_Talent3tip:Hide();
	TalentI_Talent4tip:Hide();
	TalentI_Talent5tip:Hide();
	TalentI_Talent6tip:Hide();
	TalentI_Talent7tip:Hide();
	TalentI_Talent8tip:Hide();
	TalentI_Talent9tip:Hide();
	TalentI_Talent10tip:Hide();
	TalentI_Talent11tip:Hide();
	TalentI_Talent12tip:Hide();
	TalentI_Talent13tip:Hide();
	TalentI_Talent14tip:Hide();
	TalentI_Talent15tip:Hide();
	TalentI_Talent16tip:Hide();
	TalentI_Talent17tip:Hide();
	TalentI_Talent18tip:Hide();
	TalentI_Talent19tip:Hide();
	TalentI_Talent20tip:Hide();	
	TalentI_Talent21tip:Hide();	
	TalentI_Talent22tip:Hide();	
	TalentI_Talent23tip:Hide();	
	TalentI_Talent24tip:Hide();	
	TalentI_Talent25tip:Hide();	
	TalentI_Talent26tip:Hide();	
	TalentI_Talent27tip:Hide();	
	
	TalentI_Talent0:Hide();
	TalentI_Talent0:SetBlendMode("MOD");
	TalentI_Talent0BG:Hide();
	TalentI_Talent0Text:Hide();	
	
	TalentI_Talent1:Hide();
	TalentI_Talent1:SetBlendMode("MOD");
	TalentI_Talent1BG:Hide();
	TalentI_Talent1Text:Hide();
	
	TalentI_Talent2:Hide();
	TalentI_Talent2:SetBlendMode("MOD");
	TalentI_Talent2BG:Hide();
	TalentI_Talent2Text:Hide();
	
	TalentI_Talent3:Hide();
	TalentI_Talent3:SetBlendMode("MOD");
	TalentI_Talent3BG:Hide();
	TalentI_Talent3Text:Hide();
	
	TalentI_Talent4:Hide();
	TalentI_Talent4:SetBlendMode("MOD");
	TalentI_Talent4BG:Hide();
	TalentI_Talent4Text:Hide();
	
	TalentI_Talent5:Hide();
	TalentI_Talent5:SetBlendMode("MOD");
	TalentI_Talent5BG:Hide();
	TalentI_Talent5Text:Hide();
	
	TalentI_Talent6:Hide();
	TalentI_Talent6:SetBlendMode("MOD");
	TalentI_Talent6BG:Hide();
	TalentI_Talent6Text:Hide();
	
	TalentI_Talent7:Hide();
	TalentI_Talent7:SetBlendMode("MOD");
	TalentI_Talent7BG:Hide();
	TalentI_Talent7Text:Hide();
	
	TalentI_Talent8:Hide();
	TalentI_Talent8:SetBlendMode("MOD");
	TalentI_Talent8BG:Hide();
	TalentI_Talent8Text:Hide();
	
	TalentI_Talent9:Hide();
	TalentI_Talent9:SetBlendMode("MOD");
	TalentI_Talent9BG:Hide();
	TalentI_Talent9Text:Hide();
	
	TalentI_Talent10:Hide();
	TalentI_Talent10:SetBlendMode("MOD");
	TalentI_Talent10BG:Hide();
	TalentI_Talent10Text:Hide();
	
	TalentI_Talent11:Hide();
	TalentI_Talent11:SetBlendMode("MOD");
	TalentI_Talent11BG:Hide();
	TalentI_Talent11Text:Hide();
	
	TalentI_Talent12:Hide();
	TalentI_Talent12:SetBlendMode("MOD");
	TalentI_Talent12BG:Hide();
	TalentI_Talent12Text:Hide();
	
	TalentI_Talent13:Hide();
	TalentI_Talent13:SetBlendMode("MOD");
	TalentI_Talent13BG:Hide();
	TalentI_Talent13Text:Hide();
	
	TalentI_Talent14:Hide();
	TalentI_Talent14:SetBlendMode("MOD");
	TalentI_Talent14BG:Hide();
	TalentI_Talent14Text:Hide();
	
	TalentI_Talent15:Hide();
	TalentI_Talent15:SetBlendMode("MOD");
	TalentI_Talent15BG:Hide();
	TalentI_Talent15Text:Hide();
	
	TalentI_Talent16:Hide();
	TalentI_Talent16:SetBlendMode("MOD");
	TalentI_Talent16BG:Hide();
	TalentI_Talent16Text:Hide();
	
	TalentI_Talent17:Hide();
	TalentI_Talent17:SetBlendMode("MOD");
	TalentI_Talent17BG:Hide();
	TalentI_Talent17Text:Hide();
	
	TalentI_Talent18:Hide();
	TalentI_Talent18:SetBlendMode("MOD");
	TalentI_Talent18BG:Hide();
	TalentI_Talent18Text:Hide();

	TalentI_Talent19:Hide();
	TalentI_Talent19:SetBlendMode("MOD");
	TalentI_Talent19BG:Hide();
	TalentI_Talent19Text:Hide();
	
	TalentI_Talent20:Hide();
	TalentI_Talent20:SetBlendMode("MOD");
	TalentI_Talent20BG:Hide();
	TalentI_Talent20Text:Hide();
	
	TalentI_Talent21:Hide();
	TalentI_Talent21:SetBlendMode("MOD");
	TalentI_Talent21BG:Hide();
	TalentI_Talent21Text:Hide();
	
	TalentI_Talent22:Hide();
	TalentI_Talent22:SetBlendMode("MOD");
	TalentI_Talent22BG:Hide();
	TalentI_Talent22Text:Hide();
	
	TalentI_Talent23:Hide();
	TalentI_Talent23:SetBlendMode("MOD");
	TalentI_Talent23BG:Hide();
	TalentI_Talent23Text:Hide();
	
	TalentI_Talent24:Hide();
	TalentI_Talent24:SetBlendMode("MOD");
	TalentI_Talent24BG:Hide();
	TalentI_Talent24Text:Hide();
	
	TalentI_Talent25:Hide();
	TalentI_Talent25:SetBlendMode("MOD");
	TalentI_Talent25BG:Hide();
	TalentI_Talent25Text:Hide();
	
	TalentI_Talent26:Hide();
	TalentI_Talent26:SetBlendMode("MOD");
	TalentI_Talent26BG:Hide();
	TalentI_Talent26Text:Hide();
	
	TalentI_Talent27:Hide();
	TalentI_Talent27:SetBlendMode("MOD");
	TalentI_Talent27BG:Hide();
	TalentI_Talent27Text:Hide();
	
	TalentI_TalentAmountBG:Hide();
	TalentI_TalentAmountText:Hide();
	
	local amountTab1 = 0;
	local amountTab2 = 0;
	local amountTab3 = 0;
	
	local tipNums = 0;

    if requestedClass == "Shaman" then -- 46 talents, 15, 16, 15
	    
		for i = 1, 15, 1 do
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 16, 31, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 32, 46, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		Tab1Text:SetText("Elemental");
		Tab3Text:SetText("Restoration");
		Tab2Text:SetText("Enhancement");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");
		
		
	    if currTab == 1 then

	        -- Elemental
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\ShamanElementalCombat-TopLeft", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
					
			
            -- talents
            
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_WispSplode");
			tipNums = 1;
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");
                tipNums = tonumber(tab1Talents[1]);				
			end
			TalentI_Talent1tip.tooltip = COLOUR_CHAT_WHITE .. "Convection" .. "\n" .. "Rank " .. tonumber(tab1Talents[1]) .. "/5" .. CHAT_END .. "\n" ..  "Reduces the mana cost of your Shock," .. "\n" .. "Lightning Bolt and Chain Lightning spells" .. "\n" .."by "..(tipNums*2).."%";
			TalentI_Talent1tip:Show();		
            tipNums = 0;			
    	
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Fire_Fireball");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end

	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_StoneClawTotem");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_SpiritArmor");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Fire_Immolation");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_ManaBurn");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Frost_FrostWard");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Nature_CallStorm");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
	
	
	
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Fire_SealOfFire");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab1Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Nature_EyeOfTheStorm");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Fire_ElementalDevastation");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent15Text:SetText(tab1Talents[11]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Nature_StormReach");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab1Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Fire_Volcano");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Lightning_LightningBolt01");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent22Text:SetText(tab1Talents[14]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_WispHeal");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
	
			
		
		elseif currTab == 2 then
		
		   
		
		    -- enchanment
		    TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\ShamanEnhancement-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			
			
			-- talents
			
						
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_GrimWard");
			tipNums = 1;
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");	
                tipNums = tonumber(tab2Talents[1]);					
			end
			TalentI_Talent1tip.tooltip = COLOUR_CHAT_WHITE .. "Ancestral Knowledge" .. "\n" .. "Rank " .. tonumber(tab2Talents[1]) .. "/5" .. CHAT_END .. "\n" ..  "Increases your maximum Mana by "..(tipNums*1).."%";
			TalentI_Talent1tip:Show();
			
    	
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\INV_Shield_06");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end

	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_StoneSkinTotem");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab2Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_ThunderBolt");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Nature_SpiritWolf");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Nature_LightningShield");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab2Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Nature_EarthBindTotem");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\INV_Axe_10");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab2Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
	
	
	
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Nature_MirrorImage");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[9]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_GhoulFrenzy");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Holy_Devotion");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Fire_EnchantWeapon");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Fire_FlameTounge");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Ability_Parry");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Ability_Hunter_SwiftStrike");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Holy_SealOfMight");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
			
		
		
		elseif currTab == 3 then
		
	        -- Restoration
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\ShamanRestoration-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			
			
            -- talents
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_MagicImmunity");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end
			
    	
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Frost_ManaRecharge");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end

	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_Reincarnation");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_UndyingStrength");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Nature_MoonGlow");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Frost_Stun");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Nature_HealingWaveLesser");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Nature_NullWard");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
	
	
	
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Nature_HealingTouch");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent11Text:SetText(tab3Talents[9]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Nature_ManaRegenTotem");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Nature_Tranquility");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab3Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Nature_HealingWay");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Nature_RavenForm");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[13]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Frost_WizardMark");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[14]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Frost_SummonWaterElemental");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		end
		
		TalentWindowFrame:Show();

	
	elseif requestedClass == "Warrior" then -- 52 talents, 18, 17, 17
	
		for i = 1, 18, 1 do
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 19, 35, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 36, 52, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Arms");
		Tab2Text:SetText("Fury");
		Tab3Text:SetText("Protection");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");

	    if currTab == 1 then
		
		    -- Arms
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarriorArms-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents
			
	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Ability_Rogue_Ambush");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab1Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end
		
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Ability_Parry");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Gouge");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end				
		
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_Warrior_Charge");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_EnchantArmor");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Ability_ThunderClap");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\INV_Sword_05");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Holy_BlessingOfStamina");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_BackStab");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\INV_Axe_09");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Ability_SearingArrow");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab1Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\INV_Axe_06");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab1Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Ability_Rogue_SliceDice");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\INV_Mace_01");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\INV_Sword_27");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent19Text:SetText(tab1Talents[15]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end

	        TalentI_Talent20:Show();
	        TalentI_Talent20:SetTexture("Interface\\Icons\\INV_Weapon_Halbard_01");
			if tab1Talents[16] ~= "0" then
	            TalentI_Talent20Text:SetText(tab1Talents[16]);
	            TalentI_Talent20BG:Show();
	            TalentI_Talent20Text:Show();
	            TalentI_Talent20:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Ability_ShockWave");
			if tab1Talents[17] ~= "0" then
	            TalentI_Talent22Text:SetText(tab1Talents[17]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Ability_Warrior_SavageBlow");
			if tab1Talents[18] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[18]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		elseif currTab == 2 then
		
		    -- Fury
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarriorFury-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_Purge");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Rogue_Eviscerate");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Warrior_WarCry");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[3]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Nature_StoneClawTotem");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[4]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Ability_Warrior_Cleave");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[5]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_DeathScream");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[6]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Shadow_SummonImp");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent10Text:SetText(tab2Talents[7]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end		
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Ability_Warrior_BattleShout");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[8]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Ability_DualWield");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab2Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\INV_Sword_48");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end					
		
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_Warrior_DecisiveStrike");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Shadow_DeathPact");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\Ability_Rogue_Sprint");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent19Text:SetText(tab2Talents[14]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent20:Show();
	        TalentI_Talent20:SetTexture("Interface\\Icons\\Spell_Nature_AncestralGuardian");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent20Text:SetText(tab2Talents[15]);
	            TalentI_Talent20BG:Show();
	            TalentI_Talent20Text:Show();
	            TalentI_Talent20:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Ability_GhoulFrenzy");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[16]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_BloodLust");
			if tab2Talents[17] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[17]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end				
			
		elseif currTab == 3 then
		
		    -- Protection
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarriorProtection-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			-- talents
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\INV_Shield_06");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Nature_MirrorImage");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_Racial_BloodRage");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Holy_Devotion");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[4]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Magic_MageArmor");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent7Text:SetText(tab3Talents[5]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Holy_AshesToAshes");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_Defend");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_Warrior_Revenge");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Ability_Warrior_InnerRage");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent11Text:SetText(tab3Talents[9]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Ability_Warrior_Sunder");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab3Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Warrior_Disarm");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Nature_Reincarnation");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent14Text:SetText(tab3Talents[12]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_Warrior_ShieldWall");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[13]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Ability_ThunderBolt");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[14]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end			
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Ability_Warrior_ShieldBash");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[15]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\INV_Sword_20");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[16]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\INV_Shield_05");
			if tab3Talents[17] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[17]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end				
		
		end	
		
		TalentWindowFrame:Show();
	
	elseif requestedClass == "Mage" then --16, 16, 17
	
		for i = 1, 16, 1 do 
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 17, 32, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 33, 49, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Arcane");
		Tab2Text:SetText("Fire");
		Tab3Text:SetText("Frost");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");
	
	    if currTab == 1 then
		
	        -- Arcane
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\MageArcane-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();	
			
			
			
            -- talents
            
	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Spell_Holy_DispelMagic");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab1Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Holy_Devotion");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end
	
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Nature_StarFall");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\INV_Wand_01");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_AstralRecalGroup");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Shadow_ManaBurn");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Nature_AbolishMagic");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Nature_WispSplode");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Arcane_ArcaneResilience");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab1Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Frost_IceShock");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Shadow_SiphonMana");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent15Text:SetText(tab1Talents[12]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Nature_EnchantArmor");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Shadow_Charm");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Shadow_Teleport");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent21Text:SetText(tab1Talents[15]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_Lightning");
			if tab1Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		elseif currTab == 2 then 
		
		    -- Fire
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\MageFire-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Fire_FlameBolt");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Fire_MeteorStorm");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Fire_Incinerate");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab2Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Fire_Flare");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Fire_Fireball");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Fire_FlameShock");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Fire_SelfDestruct");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Fire_Fireball02");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab2Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Fire_Fire");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[9]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Fire_SoulBurn");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab2Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Fire_FireArmor");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Fire_MasterOfElements");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent15Text:SetText(tab2Talents[12]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Nature_WispHeal");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Holy_Excorcism_02");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Fire_Immolation");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Fire_SealOfFire");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end	
		
		
		elseif currTab == 3 then 
		
		    -- Frost
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\MageFrost-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			-- talents
	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Spell_Frost_FrostWard");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab3Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Frost_FrostBolt02");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Ice_MagicDamage");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Frost_IceShard");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Frost_FrostArmor");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Frost_FreezingBreath");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
		
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Frost_Wisp");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent7Text:SetText(tab3Talents[7]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Frost_Frostbolt");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[8]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Frost_WizardMark");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[9]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Frost_IceStorm");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent11Text:SetText(tab3Talents[10]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Shadow_DarkRitual");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent12Text:SetText(tab3Talents[11]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Frost_Stun");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[12]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Frost_FrostShock");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent14Text:SetText(tab3Talents[13]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Frost_Frost");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[14]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Frost_Glacier");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[15]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Frost_ChillingBlast");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[16]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Ice_Lament");
			if tab3Talents[17] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[17]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
			
		
		end
		
		TalentWindowFrame:Show();
	
	elseif requestedClass == "Priest" then --15, 16, 16
	
		for i = 1, 15, 1 do 
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 16, 31, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 32, 47, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Discipline");
		Tab2Text:SetText("Holy");
		Tab3Text:SetText("Shadow");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");	
	
	    if currTab == 1 then 
		
	        -- Discipline
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\PriestDiscipline-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();	
			
			
			
            -- talents
            
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Magic_MageArmor");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\INV_Wand_01");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_ManaRegenTotem");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Holy_WordFortitude");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Holy_PowerWordShield");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Nature_Tranquility");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Frost_WindWalkOn");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Nature_Sleep");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Holy_InnerFire");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab1Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Hibernation");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Shadow_ManaBurn");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent15Text:SetText(tab1Talents[11]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Nature_EnchantArmor");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[12]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Holy_DivineSpirit");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[13]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Nature_SlowingTotem");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent22Text:SetText(tab1Talents[14]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Holy_PowerInfusion");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		elseif currTab == 2 then 
		
		    -- Holy
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\PriestHoly-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Spell_Holy_HealingFocus");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab2Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Holy_Renew");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Holy_SealOfSalvation");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Holy_SpellWarding");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Holy_SealOfWrath");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Holy_HolyNova");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Holy_BlessedRecovery");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Holy_LayOnHands");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[8]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Holy_Purify");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab2Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Holy_Heal02");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Holy_SearingLightPriest");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Holy_PrayerOfHealing02");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\INV_Enchant_EssenceEternalLarge");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Holy_SpiritualGuidence");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Nature_MoonGlow");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Holy_SummonLightwell");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end	
		
		
		elseif currTab == 3 then
		
	        -- Shadow
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\PriestShadow-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			
			
            -- talents
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_Requiem");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end		
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Shadow_GatherShadows");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWard");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWordPain");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Shadow_BurningSpirit");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_PsychicScream");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Shadow_SiphonMana");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Magic_LesserInvisibilty");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[9]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Shadow_ChillTouch");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent14Text:SetText(tab3Talents[10]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Shadow_BlackPlague");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent15Text:SetText(tab3Talents[11]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Shadow_ImpPhaseShift");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Shadow_UnsummonBuilding");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Shadow_ImprovedVampiricEmbrace");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Shadow_Twilight");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Shadow_Shadowform");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end					
		
		end
		
		TalentWindowFrame:Show();
	
	elseif requestedClass == "Druid" then --16, 16, 15
	
		for i = 1, 16, 1 do 
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 17, 32, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 33, 47, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Balance");
		Tab2Text:SetText("Feral");
		Tab3Text:SetText("Restoration");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");	
	
	    if currTab == 1 then
		
	        -- Balance
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\DruidBalance-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();	
			
			
			
            -- talents
            
	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Spell_Nature_AbolishMagic");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab1Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end				
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_NaturesWrath");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end				
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Nature_NaturesWrath");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_StrangleVines");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
		
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_StarFall");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\INV_Staff_01");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Nature_WispSplode");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[7]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Nature_Thorns");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[8]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Nature_CrystalBall");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Nature_NatureTouchGrow");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent11Text:SetText(tab1Talents[10]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Nature_Purge");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Arcane_StarFire");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent14Text:SetText(tab1Talents[12]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Nature_NaturesBlessing");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Nature_Sentinal");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Nature_MoonGlow");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent21Text:SetText(tab1Talents[15]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_ForceOfNature");
			if tab1Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		elseif currTab == 2 then 
		
		    -- Feral
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\DruidFeralCombat-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Ability_Hunter_Pet_Hyena");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Druid_DemoralizingRoar");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_Ambush");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab2Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Druid_Bash");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\INV_Misc_Pelt_Bear_03");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Nature_SpiritWolf");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_Hunter_Pet_Bear");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_04");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab2Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Shadow_VampiricAura");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab2Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Hunter_Pet_Cat");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Ability_GhoulFrenzy");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Ability_Racial_Cannibalize");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent15Text:SetText(tab2Talents[12]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_Druid_Ravage");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[13]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Nature_FaerieFire");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Holy_BlessingOfAgility");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent21Text:SetText(tab2Talents[15]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_UnyeildingStamina");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		elseif currTab == 3 then 
		
		
	        -- Restoration
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\DruidRestoration-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			
			
            -- talents
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_Regeneration");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Holy_BlessingOfStamina");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_HealingTouch");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Nature_HealingWaveGreater");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Ability_Druid_Enrage");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Frost_WindWalkOn");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[6]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Nature_InsectSwarm");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[7]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Ability_EyeOfTheOwl");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent11Text:SetText(tab3Talents[8]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Holy_ElunesGrace");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[9]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Nature_Rejuvenation");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent15Text:SetText(tab3Talents[10]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Nature_RavenForm");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[11]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end

	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Nature_ProtectionformNature");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[12]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\Spell_Nature_Tranquility");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent19Text:SetText(tab3Talents[13]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Nature_ResistNature");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[14]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\INV_Relics_IdolofRejuvenation");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		end
		
		TalentWindowFrame:Show();
	
	elseif requestedClass == "Rogue" then --15, 19, 17
	
		for i = 1, 15, 1 do
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 16, 34, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 35, 51, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Assassination");
		Tab2Text:SetText("Combat");
		Tab3Text:SetText("Subtlety");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");	
	
	
	    if currTab == 1 then
		
	        -- Assassination
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\RogueAssassination-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();	
			
			
			
            -- talents
            
	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Ability_Rogue_Eviscerate");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab1Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end				

	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Ability_FiegnDead");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Racial_BloodRage");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end				
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_Druid_Disembowel");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Shadow_DeathScream");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Ability_Rogue_SliceDice");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Ability_Warrior_DecisiveStrike");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_Warrior_Riposte");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_CriticalStrike");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Rogue_FeignDeath");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Ability_Poisons");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab1Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Ice_Lament");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[12]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Ability_Rogue_KidneyShot");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[13]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Shadow_ChillTouch");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent21Text:SetText(tab1Talents[14]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Nature_EarthBindTotem");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[15]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		elseif currTab == 2 then
		
		
		    -- Combat
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\RogueCombat-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\Ability_Gouge");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab2Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_RitualOfSacrifice");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Nature_Invisibilty");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_BackStab");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab2Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Parry");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Ability_Marksmanship");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWard");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_Warrior_Challange");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Ability_Rogue_Sprint");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[9]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Ability_Kick");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab2Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\INV_Weapon_ShortBlade_05");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Ability_DualWield");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[12]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\INV_Mace_01");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[13]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Ability_Warrior_PunishingBlow");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[14]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\INV_Sword_27");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[15]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\INV_Gauntlets_04");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent19Text:SetText(tab2Talents[16]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Holy_BlessingOfStrength");
			if tab2Talents[17] ~= "0" then
	            TalentI_Talent21Text:SetText(tab2Talents[17]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Ability_Racial_Avatar");
			if tab2Talents[18] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[18]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWordDominate");
			if tab2Talents[19] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[19]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		elseif currTab == 3 then 
		
		
	        -- Subtlety
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\RogueSubtlety-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			
			
			
            -- talents
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_Charm");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Warrior_WarCry");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_Rogue_Feint");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Magic_LesserInvisibilty");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Ability_Stealth");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_Fumble");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[6]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_Curse");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[7]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_Rogue_Ambush");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[8]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Nature_MirrorImage");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab3Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Sap");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\INV_Sword_17");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab3Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_Ambush");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Shadow_AntiShadow");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Shadow_SummonSuccubus");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\Spell_Shadow_LifeDrain");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent19Text:SetText(tab3Talents[15]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\INV_Weapon_Crossbow_11");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[16]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Shadow_Possession");
			if tab3Talents[17] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[17]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		
		end
		
		TalentWindowFrame:Show();
		
	
	elseif requestedClass == "Warlock" then -- 17, 17, 16
	
		for i = 1, 17, 1 do
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 18, 34, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 35, 50, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end
			
		Tab1Text:SetText("Affliction");
		Tab2Text:SetText("Demonology");
		Tab3Text:SetText("Destruction");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");
	
	    if currTab == 1 then
		
	        -- Affliction
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarlockCurses-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();		
		
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_UnsummonBuilding");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Shadow_AbominationExplosion");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Shadow_CurseOfMannoroth");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Shadow_Haunting");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end			

	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Shadow_BurningSpirit");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Spell_Shadow_LifeDrain02");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_CurseOfSargeras");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_FingerOfDeath");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Shadow_Contagion");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Shadow_CallofBone");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab1Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Shadow_Twilight");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Shadow_SiphonMana");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent15Text:SetText(tab1Talents[12]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Shadow_Requiem");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Shadow_GrimWard");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab1Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\Spell_Shadow_GrimWard");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent19Text:SetText(tab1Talents[15]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent21:Show();
	        TalentI_Talent21:SetTexture("Interface\\Icons\\Spell_Shadow_ShadeTrueSight");
			if tab1Talents[16] ~= "0" then
	            TalentI_Talent21Text:SetText(tab1Talents[16]);
	            TalentI_Talent21BG:Show();
	            TalentI_Talent21Text:Show();
	            TalentI_Talent21:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Shadow_DarkRitual");
			if tab1Talents[17] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[17]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		elseif currTab == 2 then
		
		    -- Demonology
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarlockSummoning-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
			
			
            -- talents

	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\INV_Stone_04");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab2Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_SummonImp");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Shadow_Metamorphosis");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Shadow_LifeDrain");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab2Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Shadow_SummonVoidWalker");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
			
		    TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Holy_MagicalSentry");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Shadow_SummonSuccubus");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
		    TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Nature_RemoveCurse");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Shadow_AntiShadow");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab2Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Shadow_ImpPhaseShift");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWordDominate");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Shadow_EnslaveDemon");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Shadow_PsychicScream");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\INV_Ammo_FireTar");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent19Text:SetText(tab2Talents[14]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end
			
			TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowPact");
			if tab2Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
			TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Shadow_GatherShadows");
			if tab2Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
			
			TalentI_Talent26:Show();
	        TalentI_Talent26:SetTexture("Interface\\Icons\\INV_Misc_Gem_Sapphire_01");
			if tab2Talents[17] ~= "0" then
	            TalentI_Talent26Text:SetText(tab2Talents[17]);
	            TalentI_Talent26BG:Show();
	            TalentI_Talent26Text:Show();
	            TalentI_Talent26:SetBlendMode("ALPHAKEY");			
			end
		
		
		elseif currTab == 3 then
		
		    -- Destruction
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\WarlockDestruction-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
			

	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowBolt");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Fire_WindsofWoe");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Spell_Shadow_DeathPact");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[3]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
		
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Spell_Fire_Fire");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[4]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Fire_FireBolt");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[5]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_Curse");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[6]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Spell_Fire_FlameShock");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[7]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Spell_Shadow_ScourgeBuild");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent11Text:SetText(tab3Talents[8]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Spell_Fire_LavaSpawn");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent12Text:SetText(tab3Talents[9]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Spell_Shadow_CorpseExplode");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Spell_Fire_SoulBurn");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent15Text:SetText(tab3Talents[11]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Spell_Fire_Volcano");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab3Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Fire_Immolation");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWordPain");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Fire_SelfDestruct");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Spell_Fire_Fireball");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end
		
		end
		
		TalentWindowFrame:Show();
	
	elseif requestedClass == "Hunter" then -- 16, 14 ,16
	
		for i = 1, 16, 1 do
            table.insert(tab1Talents, talents[i]);
			if talents[i] ~= "0" then
			    amountTab1 = amountTab1 + tonumber(talents[i]);
			end
        end		
		for o = 17, 30, 1 do
            table.insert(tab2Talents, talents[o]);
			if talents[o] ~= "0" then
			    amountTab2 = amountTab2 + tonumber(talents[o]);
			end
        end			
		for p = 31, 46, 1 do
            table.insert(tab3Talents, talents[p]);
			if talents[p] ~= "0" then
			    amountTab3 = amountTab3 + tonumber(talents[p]);
			end
        end				
		
		Tab1Text:SetText("Beast Mastery");
		Tab2Text:SetText("Marksmanship");
		Tab3Text:SetText("Survival");
		
		TalentWindowFrameText:SetText(storedRequestedName .. "'s talents");
	
	    if currTab == 1 then
		
	        -- Beast Mastery
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\HunterBeastMastery-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab1);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();			
					
			
            -- talents
			
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Nature_RavenForm");
			if tab1Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab1Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end		
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Nature_Reincarnation");
			if tab1Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab1Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Ability_EyeOfTheOwl");
			if tab1Talents[3] ~= "0" then
	            TalentI_Talent4Text:SetText(tab1Talents[3]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey");
			if tab1Talents[4] ~= "0" then
	            TalentI_Talent5Text:SetText(tab1Talents[4]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	

	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\INV_Misc_Pelt_Bear_03");
			if tab1Talents[5] ~= "0" then
	            TalentI_Talent6Text:SetText(tab1Talents[5]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			

	        TalentI_Talent7:Show();
	        TalentI_Talent7:SetTexture("Interface\\Icons\\Ability_Hunter_BeastSoothe");
			if tab1Talents[6] ~= "0" then
	            TalentI_Talent7Text:SetText(tab1Talents[6]);
	            TalentI_Talent7BG:Show();
	            TalentI_Talent7Text:Show();
	            TalentI_Talent7:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Ability_Mount_JungleTiger");
			if tab1Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab1Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_Druid_Dash");
			if tab1Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab1Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_BullRush");
			if tab1Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab1Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Hunter_MendPet");
			if tab1Talents[10] ~= "0" then
	            TalentI_Talent13Text:SetText(tab1Talents[10]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_04");
			if tab1Talents[11] ~= "0" then
	            TalentI_Talent14Text:SetText(tab1Talents[11]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end
			
			TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_Druid_DemoralizingRoar");
			if tab1Talents[12] ~= "0" then
	            TalentI_Talent16Text:SetText(tab1Talents[12]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end
			
			TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Ability_Devour");
			if tab1Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab1Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end
		
			TalentI_Talent19:Show();
	        TalentI_Talent19:SetTexture("Interface\\Icons\\Spell_Nature_AbolishMagic");
			if tab1Talents[14] ~= "0" then
	            TalentI_Talent19Text:SetText(tab1Talents[14]);
	            TalentI_Talent19BG:Show();
	            TalentI_Talent19Text:Show();
	            TalentI_Talent19:SetBlendMode("ALPHAKEY");			
			end		
			
			TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_03");
			if tab1Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab1Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Ability_Druid_FerociousBite");
			if tab1Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab1Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end	
			
			
		
		elseif currTab == 2 then
		
			-- Marksmanship
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\HunterMarksmanship-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab2);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();
		
		
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Frost_Stun");
			if tab2Talents[1] ~= "0" then
	            TalentI_Talent1Text:SetText(tab2Talents[1]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Spell_Frost_WizardMark");
			if tab2Talents[2] ~= "0" then
	            TalentI_Talent2Text:SetText(tab2Talents[2]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end				
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Hunter_SniperShot");
			if tab2Talents[3] ~= "0" then
	            TalentI_Talent5Text:SetText(tab2Talents[3]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Ability_SearingArrow");
			if tab2Talents[4] ~= "0" then
	            TalentI_Talent6Text:SetText(tab2Talents[4]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
		
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\INV_Spear_07");
			if tab2Talents[5] ~= "0" then
	            TalentI_Talent8Text:SetText(tab2Talents[5]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end		

	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Ability_ImpalingBolt");
			if tab2Talents[6] ~= "0" then
	            TalentI_Talent9Text:SetText(tab2Talents[6]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	

            TalentI_Talent11:Show();
	        TalentI_Talent11:SetTexture("Interface\\Icons\\Ability_TownWatch");
			if tab2Talents[7] ~= "0" then
	            TalentI_Talent11Text:SetText(tab2Talents[7]);
	            TalentI_Talent11BG:Show();
	            TalentI_Talent11Text:Show();
	            TalentI_Talent11:SetBlendMode("ALPHAKEY");			
			end		

            TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Hunter_Quickshot");
			if tab2Talents[8] ~= "0" then
	            TalentI_Talent13Text:SetText(tab2Talents[8]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end				
			
            TalentI_Talent14:Show();
	        TalentI_Talent14:SetTexture("Interface\\Icons\\Ability_PierceDamage");
			if tab2Talents[9] ~= "0" then
	            TalentI_Talent14Text:SetText(tab2Talents[9]);
	            TalentI_Talent14BG:Show();
	            TalentI_Talent14Text:Show();
	            TalentI_Talent14:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent16:Show();
	        TalentI_Talent16:SetTexture("Interface\\Icons\\Ability_GolemStormBolt");
			if tab2Talents[10] ~= "0" then
	            TalentI_Talent16Text:SetText(tab2Talents[10]);
	            TalentI_Talent16BG:Show();
	            TalentI_Talent16Text:Show();
	            TalentI_Talent16:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Ability_UpgradeMoonGlaive");
			if tab2Talents[11] ~= "0" then
	            TalentI_Talent17Text:SetText(tab2Talents[11]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Ability_Hunter_CriticalShot");
			if tab2Talents[12] ~= "0" then
	            TalentI_Talent18Text:SetText(tab2Talents[12]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\INV_Weapon_Rifle_06");
			if tab2Talents[13] ~= "0" then
	            TalentI_Talent22Text:SetText(tab2Talents[13]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end	
			
			TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\Ability_TrueShot");
			if tab2Talents[14] ~= "0" then
	            TalentI_Talent25Text:SetText(tab2Talents[14]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end	
		
		
		elseif currTab == 3 then
		
			-- Survival
	        TalentWindowFrame:SetBackdrop({bgFile = "Interface\\TalentFrame\\HunterSurvival-TopLeft.blp", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize = 372, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
			
			-- amount
			TalentI_TalentAmountText:SetText(amountTab3);
			TalentI_TalentAmountBG:Show();
			TalentI_TalentAmountText:Show();	



	        TalentI_Talent0:Show();
	        TalentI_Talent0:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Black");
			if tab3Talents[1] ~= "0" then
	            TalentI_Talent0Text:SetText(tab3Talents[1]);
	            TalentI_Talent0BG:Show();
	            TalentI_Talent0Text:Show();
	            TalentI_Talent0:SetBlendMode("ALPHAKEY");			
			end				
		
	        TalentI_Talent1:Show();
	        TalentI_Talent1:SetTexture("Interface\\Icons\\Spell_Holy_PrayerOfHealing");
			if tab3Talents[2] ~= "0" then
	            TalentI_Talent1Text:SetText(tab3Talents[2]);
	            TalentI_Talent1BG:Show();
	            TalentI_Talent1Text:Show();
	            TalentI_Talent1:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent2:Show();
	        TalentI_Talent2:SetTexture("Interface\\Icons\\Ability_Parry");
			if tab3Talents[3] ~= "0" then
	            TalentI_Talent2Text:SetText(tab3Talents[3]);
	            TalentI_Talent2BG:Show();
	            TalentI_Talent2Text:Show();
	            TalentI_Talent2:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent4:Show();
	        TalentI_Talent4:SetTexture("Interface\\Icons\\Spell_Nature_StrangleVines");
			if tab3Talents[4] ~= "0" then
	            TalentI_Talent4Text:SetText(tab3Talents[4]);
	            TalentI_Talent4BG:Show();
	            TalentI_Talent4Text:Show();
	            TalentI_Talent4:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent5:Show();
	        TalentI_Talent5:SetTexture("Interface\\Icons\\Ability_Racial_BloodRage");
			if tab3Talents[5] ~= "0" then
	            TalentI_Talent5Text:SetText(tab3Talents[5]);
	            TalentI_Talent5BG:Show();
	            TalentI_Talent5Text:Show();
	            TalentI_Talent5:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent6:Show();
	        TalentI_Talent6:SetTexture("Interface\\Icons\\Ability_Rogue_Trip");
			if tab3Talents[6] ~= "0" then
	            TalentI_Talent6Text:SetText(tab3Talents[6]);
	            TalentI_Talent6BG:Show();
	            TalentI_Talent6Text:Show();
	            TalentI_Talent6:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent8:Show();
	        TalentI_Talent8:SetTexture("Interface\\Icons\\Spell_Nature_TimeStop");
			if tab3Talents[7] ~= "0" then
	            TalentI_Talent8Text:SetText(tab3Talents[7]);
	            TalentI_Talent8BG:Show();
	            TalentI_Talent8Text:Show();
	            TalentI_Talent8:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent9:Show();
	        TalentI_Talent9:SetTexture("Interface\\Icons\\Spell_Shadow_Twilight");
			if tab3Talents[8] ~= "0" then
	            TalentI_Talent9Text:SetText(tab3Talents[8]);
	            TalentI_Talent9BG:Show();
	            TalentI_Talent9Text:Show();
	            TalentI_Talent9:SetBlendMode("ALPHAKEY");			
			end	
		
	        TalentI_Talent10:Show();
	        TalentI_Talent10:SetTexture("Interface\\Icons\\Ability_Whirlwind");
			if tab3Talents[9] ~= "0" then
	            TalentI_Talent10Text:SetText(tab3Talents[9]);
	            TalentI_Talent10BG:Show();
	            TalentI_Talent10Text:Show();
	            TalentI_Talent10:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent12:Show();
	        TalentI_Talent12:SetTexture("Interface\\Icons\\Ability_Ensnare");
			if tab3Talents[10] ~= "0" then
	            TalentI_Talent12Text:SetText(tab3Talents[10]);
	            TalentI_Talent12BG:Show();
	            TalentI_Talent12Text:Show();
	            TalentI_Talent12:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent13:Show();
	        TalentI_Talent13:SetTexture("Interface\\Icons\\Ability_Kick");
			if tab3Talents[11] ~= "0" then
	            TalentI_Talent13Text:SetText(tab3Talents[11]);
	            TalentI_Talent13BG:Show();
	            TalentI_Talent13Text:Show();
	            TalentI_Talent13:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent15:Show();
	        TalentI_Talent15:SetTexture("Interface\\Icons\\Ability_Rogue_FeignDeath");
			if tab3Talents[12] ~= "0" then
	            TalentI_Talent15Text:SetText(tab3Talents[12]);
	            TalentI_Talent15BG:Show();
	            TalentI_Talent15Text:Show();
	            TalentI_Talent15:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent17:Show();
	        TalentI_Talent17:SetTexture("Interface\\Icons\\Spell_Holy_BlessingOfStamina");
			if tab3Talents[13] ~= "0" then
	            TalentI_Talent17Text:SetText(tab3Talents[13]);
	            TalentI_Talent17BG:Show();
	            TalentI_Talent17Text:Show();
	            TalentI_Talent17:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent18:Show();
	        TalentI_Talent18:SetTexture("Interface\\Icons\\Ability_Warrior_Challange");
			if tab3Talents[14] ~= "0" then
	            TalentI_Talent18Text:SetText(tab3Talents[14]);
	            TalentI_Talent18BG:Show();
	            TalentI_Talent18Text:Show();
	            TalentI_Talent18:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent22:Show();
	        TalentI_Talent22:SetTexture("Interface\\Icons\\Spell_Nature_Invisibilty");
			if tab3Talents[15] ~= "0" then
	            TalentI_Talent22Text:SetText(tab3Talents[15]);
	            TalentI_Talent22BG:Show();
	            TalentI_Talent22Text:Show();
	            TalentI_Talent22:SetBlendMode("ALPHAKEY");			
			end	
			
	        TalentI_Talent25:Show();
	        TalentI_Talent25:SetTexture("Interface\\Icons\\INV_Spear_02");
			if tab3Talents[16] ~= "0" then
	            TalentI_Talent25Text:SetText(tab3Talents[16]);
	            TalentI_Talent25BG:Show();
	            TalentI_Talent25Text:Show();
	            TalentI_Talent25:SetBlendMode("ALPHAKEY");			
			end	
		
		end
		
		TalentWindowFrame:Show();
	
	end
	

end


local TalentI_UIDropDownMenu_AddButton = UIDropDownMenu_AddButton;
UIDropDownMenu_AddButton = function(info, level)
	if(USER_DROPDOWNBUTTONS[info.value]) then
		local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
		info.func = USER_DROPDOWNBUTTONS[info.value].func;
	end;
	TalentI_UIDropDownMenu_AddButton(info,level);
end;

DEFAULT_CHAT_FRAME:AddMessage(COLOUR_CHAT .. "TalentInspector, version: 0.9, Rehgar - GG @ Elysium" .. CHAT_END);
TalentI_addDropDownMenuButton("TalentInspector", "PLAYER", 3, "Talents", true, TalentI_Inspect);
TalentI_addDropDownMenuButton("TalentInspectorP", "PARTY", 5, "Talents", true, TalentI_Inspect);
TalentI_addDropDownMenuButton("TalentInspectorR", "RAID", 5, "Talents", true, TalentI_Inspect);
TalentI_RegisterEvents();
TalentI_UpdateTalents();

TIFrame:SetScript("OnEvent", TalentI_OnEvent);