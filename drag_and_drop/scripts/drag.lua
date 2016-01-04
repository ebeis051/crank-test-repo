--[[
Copyright 2013, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

--new comment evan's change

local last_pressed_control = nil
local front = 100

-- this function is called on motion events
function drag(mapargs)
	local ev_data = mapargs.context_event_data;
	
	-- if no control selected just return
	if last_pressed_control == nil then
		return
	end
	
	--set postion to touch co-ord (-34 to make it center on image)
	local pos = {}
	pos["x"] = ev_data.x - 34
	pos["y"] = ev_data.y -  34
	
	-- set the control to the new position
	gre.set_control_attrs(last_pressed_control, pos)
end



-- When a control is pressed on, save the name of the control
function press(mapargs)
	last_pressed_control = mapargs.context_control
	
	front = front + 1
	
	local data = {}
	data[mapargs.context_control..".grd_zindex"] = front
	gre.set_data(data)
end

-- When a release happens, clear the saved control name
function release(mapargs)
	last_pressed_control = nil
end

