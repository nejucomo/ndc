local function repr(obj)
   if type(obj) == 'string' then
      return ('%q'):format(obj)
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
