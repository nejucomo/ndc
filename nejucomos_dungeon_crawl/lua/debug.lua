local function repr(obj)
   if type(obj) == 'string' then
      return ('%q'):format(obj)

   elseif type(obj) == 'table' then

      local result = '}'

      for k, v in pairs(obj) do
         if result == nil then
            result = result .. ' '
         else
            result = result .. ', '
         end
         result = result .. repr(k) .. ' = ' .. tostring(v)
      end

      if result == '{' then return '{}' else return result .. ' }' end

   else
      return tostring(obj)
   end
end


local function format(tmpl, ...)
   local i = 0
   local args = {...}

   local function repl(match)
      i = i + 1
      if match == '%r' then
         args[i] = repr(args[i])
         return '%s'
      else
         return match
      end
   end

   return tmpl:gsub('%%.', repl):format(unpack(args))
end


local function dump(tmpl, ...)
   local message = '[NDC DEBUG] ' .. format(tmpl, ...)

   print(message)
   wesnoth.fire('chat', { speaker = 'NDC DEBUG', message = message } )
end


return setmetatable(
   {
      repr = repr,
      format = format,
      dump = dump,
   },
   {
      __call = function (mod, ...) return dump(...) end,
   })
