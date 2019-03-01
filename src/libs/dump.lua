local maxdepth = 16

local function indent(depth)
   local s = ''
   for i=0,depth do s=s..'  ' end
   return s
end

function dump(table, showmeta, depth)
   if type(table) ~= 'table' then return tostring(table) end
   if not next(table) then return '{}' end

   local depth = depth or 0
   local result = ''

   if showmeta and getmetatable(table) then
      result = result..'setmetatable('
   end

   result = result .. '{\n'

   for k,v in pairs(table) do
      k = type(k) == 'number' and ((k>0 and k <= #table) and k or "["..k.."]")
       or type(k) == 'function' and "'"..tostring(k).."'"
       or type(k) == 'string' and k
       or type(k) == 'table' and {dump(k, showmeta, depth+1)..' = '}
       or "'"..k.."'"

      v = type(v) == 'string' and "'"..v:gsub("'", "\\'").."'"
       or type(v) == 'function' and "'"..tostring(v).."'"
       or v

      k = type(k) == 'number' and '' or (type(k) == 'table' and k[1] or k .. ' = ')

      if type(v) == 'table' and depth<maxdepth then
         result = result .. indent(depth) .. k .. dump(v, showmeta, depth+1) .. ",\n"

      elseif depth<maxdepth then
         result = result .. indent(depth) .. k .. tostring(v) .. ',\n'

      else
         return result

      end
   end

   result = result .. indent(depth-1) .. '}'

   if showmeta and getmetatable(table) then
      result = result..', '..dump(getmetatable(table), showmeta, depth)..')'
   end

   return result
end
