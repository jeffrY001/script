script_author('jeffrY.')

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local ev = require('lib.samp.events')
local active = false
local night = false

updates = false

local script_vers = 2
local script_vers_text = '1.1'
local update_url = 'https://raw.githubusercontent.com/jeffrY001/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://github.com/jeffrY001/script/blob/main/vision.luac?raw=true'
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(2500) end

	sampAddChatMessage("{6666FF}Vision: {ffffff}Автор скрипта: {6666FF}jeffrY{ffffff}. {ffffff}Активация: {6666ff}/vis", 0xffffff)
	sampRegisterChatCommand('vis', vis)
	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			update_ini = inicfg.load(nil, update_path)
			if tonumber(update_ini.info.vers) > script_vers then
				sampAddChatMessage('{6666FF}Vision: {ffffff}Доступно новое {6666FF}ОБНОВЛЕНИЕ',-1)
				updates = true
			end
			os.remove(update_path)
		end
	end)

	while true do
	    wait(0)
	    if updates then
	    	downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					thisScript():reload()
					sampAddChatMessage('{6666FF}Vision: {ffffff}скрипт успешно обновлён.', -1)
				end
			end)
			break
	    end
	end
end

function vis()
    sampShowDialog(8003, '{FF5656}Vision {ffffff}by {FF5656}jeffrY.', '1. Ночное видение\n2. Инфракрасное видение', 'Выбрать', 'Закрыть', 4)
    lua_thread.create(vis_list)
end

function vis_list()
	while sampIsDialogActive() do
    	wait(0)
    	local result, button, list, input = sampHasDialogRespond(8003)
        if result then
            if button == 1 and list == 0 then
            	night = not night
				sampAddChatMessage(night and '{ffffff}Ночное видение {008000}ON' or '{ffffff}Ночное видение {FF5656}OFF', -1)
				setNightVision(night)
            end
            if button == 1 and list == 1 then
            	active = not active
				sampAddChatMessage(active and '{ffffff}Инфракрасное видение {008000}ON' or '{ffffff}Инфракрасное видение {FF5656}OFF', -1)
				setInfraredVision(active)
            end
        end
    end
end


