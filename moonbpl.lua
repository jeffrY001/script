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

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			update_ini = inicfg.load(nil, update_path)
			if tonumber(update_ini.info.vers) > script_vers then
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
				end
			end)
			break
	    end
	end
end
