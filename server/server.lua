local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- Job Apply
-----------------------------------------------------------------------
RegisterNetEvent('rex-townhall:server:applyjob', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local currentjob = Player.PlayerData.job.name
    if not Player then return end
    if currentjob ~= data.job then
        local cashBalance = Player.PlayerData.money['cash']
        if cashBalance >= data.jobcost then
            Player.Functions.RemoveMoney('cash', data.jobcost)
            Player.Functions.SetJob(data.job, data.grade)
            TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_1'), type = 'inform', duration = 7000 })
            for _,jobitems in pairs(data.jobitems) do
                Player.Functions.AddItem(jobitems.item, jobitems.amount)
                TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[jobitems.item], 'add', jobitems.amount)
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_2'), type = 'inform', duration = 7000 })
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_3'), type = 'inform', duration = 7000 })
    end
end)
