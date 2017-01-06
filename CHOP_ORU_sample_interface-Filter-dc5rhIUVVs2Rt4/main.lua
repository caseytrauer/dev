-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   
   local Orig, Msg, Err = hl7.parse{vmd='chop_lab_result.vmd',data=Data}
   local Out = hl7.message{vmd='chop_lab_result.vmd',name='Lab_Result'}
   
   Out:mapTree(Orig)
   trace(Out)
      
   ProcessOBX(Out.OBX)
   
   
end

function ProcessOBX(O) 

   local artsNum = 0
   trace(O)
   -- Find segments that contain ART in OBX.5.1   
   for i=1, #O do 
trace(O[i][1]:nodeValue())
      if O[i][5][1]:nodeValue() == 'ART' then
   
         -- Splits identifier by hyphens
         local id = O[i][3][1]:nodeValue():split('-')
	        
         trace(id)
 
         artsNum = artsNum + 1
         TransformIDs(O,id, artsNum)
         

         
         elseif O[i][2]:nodeValue() == 'ST' then
         
         O:remove(i)
         
      else

      end

  
   end
   
   trace(O)
   
   -- Grab previous three segments and convert OBX.3.1 values
   
   -- Return
   
end


function TransformIDs(O,id,num) 
      
for j=1, #O do 
   
      
      local identifier = O[j][3][1]:nodeValue()
      local identifierCode = identifier:sub(identifier:len(),identifier:len())
      trace(identifierCode)
      
      if identifier:find(id[2],1)~=nil 
         and identifier:find(id[3],1)~=nil 
         and (identifierCode == 'S' 
            or identifierCode == 'D' 
            or identifierCode == "M") then 
      
         -- replace identifier with ART and iterator
         O[j][3][1] = id[1] .. '-' .. id[2] .. '-' .. 'ART' .. num .. '-' .. identifierCode
         
         
      elseif identifier:find(id[2],1)~=nil 
         and identifier:find(id[3],1)~=nil
         and identifier:find('HR',1) then

         -- remove HR observations
         O:remove(j)
         
         elseif identifier:find(id[2],1)~=nil 
         and identifier:find(id[3],1)~=nil 
         and O[j][5][1]:nodeValue() == 'ART' then

         -- remove ST observation
         O:remove(j)
         
      end
   
   end

 return O  
end