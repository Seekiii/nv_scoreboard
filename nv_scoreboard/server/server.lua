ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("nv_advanced_scoreboard:server:playerList")
AddEventHandler("nv_advanced_scoreboard:server:playerList",function()
	local src = source
	print()
	local nuiData = {type="playerlist",data=get_player_list()}
	TriggerClientEvent("nv_advanced_scoreboard:client:update_nui",src,nuiData)
end)

function get_player_list()
	while ESX == nil do
        Citizen.Wait(500)
    end
    local playerlist = {}
    for _, playerId in ipairs(GetPlayers()) do
        local ping = GetPlayerPing(playerId)
        local job = "N/A"
        local name = "N/A"

        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            job = xPlayer.getJob().label
            name = xPlayer.getName()
        end
        local steamName = GetPlayerName(playerId)

        table.insert(playerlist, {
            id = playerId,
            name = name,
            ping = ping,
            steamName = steamName,
            job = job
        })
    end
    return playerlist
end
function string:replace(oldText, newText)
    return self:gsub(oldText, newText)
end