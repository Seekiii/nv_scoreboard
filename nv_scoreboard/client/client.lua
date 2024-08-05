local isOpen = false
RegisterNetEvent("nv_advanced_scoreboard:client:update_nui")
AddEventHandler("nv_advanced_scoreboard:client:update_nui",function(data)
	SendNUIMessage(data)
end)

RegisterNetEvent("nv_advanced_scoreboard:client:exit")
AddEventHandler("nv_advanced_scoreboard:client:exit",function()
	open_panel(not isOpen)
end)

RegisterNUICallback("exit",function(data,cb)
	cb({status=true})
	if isOpen then
		open_panel(not isOpen)
	end
end)


RegisterKeyMapping('nv_advanced_scoreboard:open', 'Nevera Advanced Scoreboard', 'keyboard', config.openScoreboardKey)
RegisterCommand('nv_advanced_scoreboard:open', function()
	TriggerServerEvent("nv_advanced_scoreboard:server:playerList")
	open_panel(not isOpen)
end, false)

function open_panel(status)
	if (status) then
		SetNuiFocus(true,false)	
	else
		SetNuiFocus(false,false)
	end
    local NUIData = {type="visible",data=status,theme=config.theme}
    TriggerEvent("nv_advanced_scoreboard:client:update_nui",NUIData)
    isOpen = status
end

function string:replace(oldText, newText)
    return self:gsub(oldText, newText)
end
