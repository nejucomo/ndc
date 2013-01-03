local function contains(seq, item)
   for k, v in ipairs(seq) do
      if v == item then return true end
   end
end


return contains
