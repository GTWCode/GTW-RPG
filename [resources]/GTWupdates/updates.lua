--[[
********************************************************************************
	Project owner:		RageQuit community
	Project name: 		GTW-RPG
	Developers:   		Mr_Moose

	Source code:		https://github.com/GTWCode/GTW-RPG/
	Bugtracker: 		http://forum.404rq.com/bug-reports/
	Suggestions:		http://forum.404rq.com/mta-servers-development/

	Version:    		Open source
	License:    		GPL v.3 or later
	Status:     		Stable release
********************************************************************************
]]--

-- Create the updates window
local x,y = guiGetScreenSize()
local window = exports.GTWgui:createWindow((x-800)/2, (y-600)/2, 800, 600, "Grand Theft Walrus - Server updates", false )
local text = guiCreateMemo( 10, 30, 780, 526, "", false, window )

-- Set readonly, apply GUI style and hide
guiMemoSetReadOnly(text, true)
guiSetVisible(window,false)
exports.GTWgui:setDefaultFont(text, 10)

-- Add close button and triggers
local closeButton = guiCreateButton(10,560,780,30,"Close window",false,window)
exports.GTWgui:setDefaultFont(closeButton, 10)
addEventHandler("onClientGUIClick",closeButton,function()
	guiSetVisible(window, false)
	showCursor(false)
end)

-- Refresh and toggle updates list
function requestUpdates()
	-- Request updates list from RageQuit network (unavailable)
	--[[oldText = guiGetText(text)
	if oldText == "" then
		guiSetText(text, "Connecting to hub.404rq.com for latest updates, please wait...")
	end
	triggerServerEvent("GTWupdates.request", resourceRoot)
	function onResponseFromServer(message)
	    -- Report changes to online players
	    if oldText ~= message and guiGetVisible(window) then
	    	guiSetText(text,message)
	    	exports.GTWtopbar:dm("Updates downloaded from: gs.gtw-games.org", 180, 180, 180 )
	    elseif oldText ~= message then
	    	guiSetText(text,message)
	    	exports.GTWtopbar:dm("Updates downloaded from: gs.gtw-games.org! Use /updates to see what's new", 180, 180, 180 )
	    end
	end
	addEvent( "GTWupdates.respond", true )
	addEventHandler("GTWupdates.respond", localPlayer, onResponseFromServer)]]--

	-- Load updates from local file
	--[[local update_file = fileOpen("updates.txt", true)
	local content = ""
	if not update_file then return end
	local buffer
	while not fileIsEOF(update_file) do
	 	buffer = fileRead(update_file, 500)
		content = content..buffer
	end
	fileClose(update_file)]]--

	-- Add text to list
	guiSetText(text, str_updates)
end
setTimer(requestUpdates,10000,0)

function viewUpdateListGUI()
	guiSetVisible(window, not guiGetVisible(window))
	guiBringToFront(window)
	requestUpdates()
end
function toggleUpdateListGUI()
	guiSetVisible(window, not guiGetVisible(window))
	showCursor(not isCursorShowing())
	requestUpdates()
end
addCommandHandler( "updates", toggleUpdateListGUI )

function getUpdatesList()
	return guiGetText(text)
end
