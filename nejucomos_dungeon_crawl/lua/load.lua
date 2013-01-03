-- NDC lua: module loading infrastructure --

local modcache = {}


return function (name)
          local mod = modcache[name]
          if mod == nil then
             local path = "~/add-ons/nejucomos_dungeon_crawl/lua/" .. name .. ".lua"
             print('NDC lua load("' .. path .. '")')
             mod = wesnoth.require(path)
             modcache[name] = mod
          end
          return mod
       end
