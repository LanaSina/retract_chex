
local http = require "socket.http"

local data = ""

function collect(chunk)
    if chunk ~= nil then
        data = data .. chunk
    end
  return true
end

local ok, statusCode, headers, statusText = http.request {
  method = "GET",
  url = "http://openretractions.com/api/doi/10.1002/job.1787/data.json",
  -- url = "http://www.omdbapi.com/?t=soul",
  sink = collect
}

local json = require('json.lua')
local parsed = json.parse(data)
-- tex.print(data)
-- tex.print(parsed["title"])
-- tex.print(parsed["updates"][1]["type"])
-- tex.print(parsed["updates"][1]["identifier"]["doi"])

local value = string.format("%s: %s (latest doi: %s)", 
                     parsed["title"],
                    parsed["updates"][1]["type"],
                    parsed["updates"][1]["identifier"]["doi"])

tex.print(value)

-- write in a document
local marg = assert(io.open("result.txt","w")) 
marg:write(value) 
-- marg:write(statusText)
marg:flush() 
marg:close() 
