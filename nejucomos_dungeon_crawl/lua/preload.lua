local helper = wesnoth.require "lua/helper.lua"

local _ = wesnoth.textdomain "NDC"


-- public module interface --
ndc = {
   give_improvement = function (unitid)
                         local unit = wesnoth.get_unit(unitid)
                         local improvements = available_improvements(unit)
                         helper.get_user_choice({ speaker = "test" }, improvements)
                      end;
}


-- improvements --

local IMPROVEMENTS = {
   NimbleStaff = {
      description = _ "Apply experience with your staff to get the first strike when defending.";
      image = "attacks/staff-magic.png";
      units = { "NDC_Wanderer", "NDC_Adept" };
      prereqs = {};
      action = function (cfg)
               end;
   };
}


local function available_improvements(unit)

   local function has_all_prereqs(prereqs)
      --[[
      for i, prereq in ipairs(prereqs) do
         foo
      end
      ]]
      return true
   end

   local matches = {}

   for name, imp in pairs(IMPROVEMENTS) do
      if contains(imp.units, unit.type) then
         if has_all_prereqs(unit, imp.prereqs) then
            matches[#matches+1] = imp.description
         end
      end
   end
   return matches
end


-- general utilities --
local function contains(seq, item)
   for k, v in ipairs(seq) do
      if v == item then return true end
   end
end


-- log & return --
print('NDC preload.lua.')
return ndc
