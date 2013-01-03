local _ = wesnoth.textdomain "NDC"

local helper = wesnoth.require "lua/helper.lua"

local contains = ndc_load "utils"


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



local function give_improvement (unit)
   local improvements = available_improvements(unit)
   helper.get_user_choice({ speaker = "test" }, improvements)
end


-- public module interface --
return {
   give_initial_improvements = function (sideid)
                                  if contains({1, 2, 3, 4}, sideid) then
                                     local leader = wesnoth.get_units { side = sideid, canrecruit = true }
                                     give_improvement(leader)
                                  end
                               end;
}
