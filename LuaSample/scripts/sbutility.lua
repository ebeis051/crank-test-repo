--[[
Copyright 2015, Crank Software Inc.
All Rights Reserved.
For more information email info@cranksoftware.com
** FOR DEMO PURPOSES ONLY **
]]--

-- This Lua module provides a set of useful functions that
-- can be handy when doing Storyboard development.
--
-- These functions are intended to be copied and customized.

-- 
-- Print the content of a table in a visually pleasing fashion
--
-- Use this as: 
--  DumpTable(mytable_variable)
--
--@param aTable A non-nil table
--@param prefix [optional] An optional prefix for the content
--@param history [internal] Used for recursion
function DumpTable(aTable, prefix, history)
	if(prefix == nil) then
		prefix = ""
	end
	if(history == nil) then
		history = {}
	end
	
	-- Avoid recusion by checking the history
	if(history[aTable]) then
		print(prefix .. " => Loops Back")
		return
	end

	history[aTable] = true
	for k,v in pairs(aTable) do
		if(type(v) == "table") then
			DumpTable(v, prefix .. tostring(k) .. ".", history)
		else
			print(prefix .. tostring(k) .. " = " .. tostring(v))
		end		
	end
end

-- Local variable used to trace overall trace indentation level
local traceIndent = 0

-- 
-- Trace the function execution of scripts with indentation
--
-- 
local function TraceCallback(ev) 
	if(ev == "call") then
		local functionName = debug.getinfo(2, "n").name
		local indentString = string.rep(" ", traceIndent)
		print(string.format("%s> %s", indentString, tostring(functionName)))
		traceIndent = traceIndent + 1
	elseif(ev == "return" or ev == "tail return") then
		if(traceIndent > 0) then
			traceIndent = traceIndent - 1
		end
	elseif(ev == "line") then
	   -- Nothing currently done for line trace events
	end
end

function FunctionTraceControl(enable)
	if(enable == true) then
    -- This enables call and return hooks	   
		debug.sethook(TraceCallback, "cr")
		-- This enables line function tracing as well
    --debug.sethook(TraceCallback, "crl")
	else
		debug.sethook()
	end
end

