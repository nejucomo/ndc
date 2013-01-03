return function (tmpl, ...)
          local message = '[NDC DEBUG] ' .. string.format(tmpl, ...)

          print(message)
          wesnoth.fire('chat', { message = message } )
       end
