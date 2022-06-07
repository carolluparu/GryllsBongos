-- See (https://www.wowinterface.com/forums/showthread.php?t=5889) for BBar commands

GryllsBongos_Settings = {
    bar1 = "none",
    bar2 = "none",
    bar3 = "none",
    bar4 = "none",
    bar5 = "none",
    bar6 = "none",
    bar7 = "none",
    bar8 = "none",
    bar9 = "none",
    bar10 = "none",
}

local function setVar(i, action)
    if i == 1 then
        if action ~= nil then  
            GryllsBongos_Settings.bar1 = action
        else
            return GryllsBongos_Settings.bar1
        end        
    elseif i == 2 then
        if action ~= nil then  
            GryllsBongos_Settings.bar2 = action
        else
            return GryllsBongos_Settings.bar2
        end        
    elseif i == 3 then
        if action ~= nil then  
            GryllsBongos_Settings.bar3 = action
        else
            return GryllsBongos_Settings.bar3
        end        
    elseif i == 4 then
        if action ~= nil then  
            GryllsBongos_Settings.bar4 = action
        else
            return GryllsBongos_Settings.bar4
        end             
    elseif i == 5 then
        if action ~= nil then  
            GryllsBongos_Settings.bar5 = action
        else
            return GryllsBongos_Settings.bar5
        end               
    elseif i == 6 then
        if action ~= nil then  
            GryllsBongos_Settings.bar6 = action
        else
            return GryllsBongos_Settings.bar6
        end              
    elseif i == 7 then
        if action ~= nil then  
            GryllsBongos_Settings.bar7 = action
        else
            return GryllsBongos_Settings.bar7
        end               
    elseif i == 8 then
        if action ~= nil then  
            GryllsBongos_Settings.bar8 = action
        else
            return GryllsBongos_Settings.bar8
        end                
    elseif i == 9 then
        if action ~= nil then  
            GryllsBongos_Settings.bar9 = action
        else
            return GryllsBongos_Settings.bar9
        end              
    elseif i == 10 then
        if action ~= nil then  
            GryllsBongos_Settings.bar10 = action
        else
            return GryllsBongos_Settings.bar10
        end       
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF9900Grylls|rBongos: could not find setting for i = "..i)
    end
end

local function bongosToggle(barnum)
    local bar = BBar.IDToBar(barnum)
    BBar.Toggle(bar, false)
end

local function bongosHide(barnum)
    local bar = BBar.IDToBar(barnum)
    BBar.Hide(bar, false)
end

local function bongosShow(barnum)
    local bar = BBar.IDToBar(barnum)
    BBar.Show(bar, false)
end

local function bongosSetAlpha(barnum, alpha)
    local bar = BBar.IDToBar(barnum)
    BBar.SetAlpha(bar, alpha, false)
end

local function BarToggle()
    for i = 1, 10 do
        if setVar(i) == "toggle" then
            bongosToggle(i)
        end
    end
end

local function BarHide()
    for i = 1, 10 do        
        if setVar(i) == "hide" then
            bongosHide(i)
        end
    end
end

local function BarShow()
    for i = 1, 10 do
        if setVar(i) == "show" then
            bongosShow(i)
        end
    end
end

local function BarMouseoverSetScript(barnum)
    local bar = BBar.IDToBar(barnum)    

    local f = CreateFrame("Frame", nil, UIParent)
    f:SetAllPoints(bar)
    f:SetFrameStrata("LOW")
    f:EnableMouse(true)
    f.fadetime = 0
    f.fader = CreateFrame("Frame", nil, UIParent)
    
    f:SetScript("OnEnter", function()
        bongosShow(barnum)
        -- bongosSetAlpha(barnum, 1)   
    end)
    
    f:SetScript("OnLeave", function()
        f.fadetime = GetTime() + 2 -- adjust to your desired fade timr in seconds (minimum 1)
        f.fader:SetScript("OnUpdate", function()
            if GetTime() >= f.fadetime then
                -- bongosSetAlpha(barnum, 0)
                bongosHide(barnum)
                f.fader:SetScript("OnUpdate", nil)
            end
        end)        
    end)

    bongosHide(barnum)
    -- bongosSetAlpha(barnum, 0)
end

-- local function BarMouseoverRemoveScript(barnum)
--     local bar = BBar.IDToBar(barnum)

--     bar:SetScript("OnEnter", nil)
--     bar:SetScript("OnLeave", nil)
-- end

local function BarMouseover()
    for i = 1, 10 do
        --BarMouseoverRemoveScript(i)
        if setVar(i) == "mouseover" then
            BarMouseoverSetScript(i)
        end
    end
end

local function BarUpdate()
    BarToggle()
    BarHide()
    BarShow()
    BarMouseover()
end

local function BarReset()
    for i = 1, 10 do
        setVar(i, "none")
    end
end

local function GryllsBongos_commands(msg, editbox)
    local yellow = "FFFFFF00"
    local orange = "FFFF9900"

    local function fontnum(msg)
        local startPos = string.find(msg, "%d")
        local numstr = string.sub(msg, startPos)
        if tonumber(numstr) then
            return tonumber(numstr)
        else
            DEFAULT_CHAT_FRAME:AddMessage("Grylls|rBongos:|r bar number was not found, please try again")
        end
    end

    local barnum = nil
    if string.find(msg, "mouseover bar %d") then
        barnum = fontnum(msg)
        setVar(barnum, "mouseover")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r Bar "..barnum.." is set to mouseover (please reload)")
        BarUpdate()
    elseif string.find(msg, "toggle bar %d") then
        barnum = fontnum(msg)
        setVar(barnum, "toggle")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r Bar "..barnum.." is set to toggle (please reload to sync toggled bars)")
        BarUpdate()
    elseif string.find(msg, "hide bar %d") then
        barnum = fontnum(msg)
        setVar(barnum, "hide")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r Bar "..barnum.." is set to hidden")
        BarUpdate()
    elseif string.find(msg, "show bar %d") then
        barnum = fontnum(msg)
        setVar(barnum, "show")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r Bar "..barnum.." is set to show")
        BarUpdate()
    elseif msg == "toggle" then
        BarToggle()
    elseif msg == "update" then -- debug function
        BarUpdate()
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r updated bars")
    elseif msg == "reset" then
        BarReset()
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos:|r bars reset (requires reload)")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|c"..orange.."Grylls|rBongos usage:|r")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb mouseover bar n|r - show bar n on mouseover")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb toggle|r - toggles all bars that are set to toggle")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb toggle bar n|r - toggle bar n with command")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb hide bar n|r - hide bar n")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb show bar n|r - show bar n")
        DEFAULT_CHAT_FRAME:AddMessage("|c"..yellow.."/gb reset|r - resets all bar settings")
	end
end

local GryllsBongos = CreateFrame("Frame", nil, UIParent)
GryllsBongos:RegisterEvent("ADDON_LOADED")
GryllsBongos:RegisterEvent("PLAYER_ENTERING_WORLD")
GryllsBongos:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" then
        if not GryllsBongos.loaded then        
            SLASH_GRYLLSBONGOS1 = "/gryllsbongos"
            SLASH_GRYLLSBONGOS2 = "/gb"
            SlashCmdList["GRYLLSBONGOS"] = GryllsBongos_commands
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF9900Grylls|rBongos loaded! /gb")
            GryllsBongos.loaded = true
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        BarUpdate()
    end
end)