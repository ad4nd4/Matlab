classdef lab2_4
   properties
       x1 = (1 + 1/4) * 2^ (-124);
       x2 = -5.877472 * 10^ (-38);
   end
  
   methods
       function result = f2_4(obj)
           result = isequal(num2bitstr(single(obj.x1)), num2bitstr(single(obj.x2)));
       end
   end
end




