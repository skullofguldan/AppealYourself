local originalFn = Hardcore.PLAYER_DEAD;

function Hardcore:PLAYER_DEAD(...)
    StaticPopup_Show("GRIEFDEATH")
end

StaticPopupDialogs["GRIEFDEATH"] = {
    text = "Was this death a grief? (If you press yes, make sure you were not spotted by another player)",
    button1 = "Yes",
    button2 = "No",
    OnCancel = function()
        -- not griefed
        return originalFn(self)
    end,
    OnAccept = function()
        -- griefed
        Hardcore:Print("You died! :( But we're ignoring it! You were probably griefed by a mob or something :) Shhh...")
        StaticPopup_Hide("GRIEFDEATH")
        return true
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3, -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

function Hardcore:PLAYER_UNGHOST(...)
    if UnitIsDeadOrGhost("player") == 1 then
        return
    end
    Hardcore:Print("You resurrected, but you probably had a good reason. Shhh... We won't tell anyone.")
end

function Hardcore:MAIL_SHOW()
    Hardcore:Print("You can use the mailbox, but don't tell anyone! Shhh...")
end

function Hardcore:AUCTION_HOUSE_SHOW()
    Hardcore:Print("You can use the auction house, but don't tell anyone! Shhh...")
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)
