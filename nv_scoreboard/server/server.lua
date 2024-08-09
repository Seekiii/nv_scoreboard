ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("nv_advanced_scoreboard:server:playerList")
AddEventHandler("nv_advanced_scoreboard:server:playerList",function()
	local src = source
	local nuiData = {type="playerlist",data=get_player_list()}
	TriggerClientEvent("nv_advanced_scoreboard:client:update_nui",src,nuiData)
end)

local players = {} -- new table to cache player data (xPlayer is too big!)

AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    Wait(3000)
    local name = xPlayer.getName() or "Unknown"
    local job = xPlayer.getJob().label or "Unknown"
    local steamName = GetPlayerName(source) or "Unknown"

    players[source] = {
        name = name,
        job = job,
        steamName = steamName
    }
end)

AddEventHandler('esx:setJob', function(source, job, lastJob)
    players[source].job = ESX.GetPlayerFromId(source).getJob().label
end)

AddEventHandler('esx:playerDropped', function(source)
    players[source] = nil
end)

function get_player_list()
    local playerlist = {}
    for k, v in pairs(players) do
        local xPlayer = ESX.GetPlayerFromId(k)
        if xPlayer then
            local ping = GetPlayerPing(k) or 0
            table.insert(playerlist, {
                id = k,
                name = v.name,
                job = v.job,
                steamName = v.steamName,
                ping = ping
            })
        end
    end
    return playerlist
end

function string:replace(oldText, newText)
    return self:gsub(oldText, newText)
end
