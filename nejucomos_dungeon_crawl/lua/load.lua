-- NDC lua: module loading infrastructure --

local pathbase = "~/add-ons/nejucomos_dungeon_crawl/lua/"

local modcache = {
   debug = wesnoth.require(pathbase .. "debug.lua")
}

local debug


local function ndc_load (name)
          local mod = modcache[name]

          if mod == nil then
             debug('load %q', name)

             local path = pathbase .. name .. '.lua'
             mod = wesnoth.require(path)
             modcache[name] = mod
          end
          return mod
       end


debug = ndc_load "debug"
debug("Loading from directory: %q", pathbase)

return ndc_load
