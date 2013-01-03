return function (tmpl, ...)
          local message = '[NDC DEBUG] ' .. string.format(tmpl, ...)

          print(message)
          wesnoth.fire('chat', { speaker = 'NDC DEBUG', message = message } )
       end
