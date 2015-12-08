-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
require('parseTools')

-- Global variable setting the core target of the web service 
WEB_API_URL = 'http://labs.interfaceware.com:6544/1/'
MY_ID = 'casey.trauer@interfaceware.com'
MY_SECRET = '9d06be03-acb2-4c6b-ac21-fa623b63e630'

function main(Data)
   
   -- Standard HL7 parsing routine
   local MsgIn, MsgType = hl7.parse{vmd='demo2.vmd',data=Data}
   local MsgOut = hl7.message{vmd='demo2.vmd',name=MsgType}
   MsgOut:mapTree(MsgIn)

   local auth = {}
   auth.password = MY_SECRET
   auth.username = MY_ID

   -- RETRIEVE TOKEN
   local response, err, head = net.http.post{url=WEB_API_URL .. 'token', parameters=auth, live=true}
   
   -- Local mapping requirements
   -- 1. Change patient first name and last name
   -- 2. Change address to fictitional US address
   -- 3. Change names of kin to someone you know
   
   
   -- Set target resource ID based on MRN
   -- Hint: One of the first values in PID
   local mrn = MsgOut.PID[3][1][1]:nodeValue()

   trace (MsgOut.MSH[9][2]:nodeValue())
   
   
   -- Parse and prepare PID patient demo data for query
   
   -- Submit patient data to web serice
   
   -- Trace the query, response and headers returned from the web service.
   
   
   
   
   -- Parse and prepare PID address data for query
   
   -- Submit address data to web service
   
   -- Trace the query, response and headers returned from the web service.

   
   -- Add a test for A29 (Delete patient record)
   -- If A29, delete the patient record
   -- Otherwise, process as normal.
 
   
   -- Test a getPatient query.
   
   -- In the shared module, create functions to:
   -- a) parse out first name, last name and relationship from NK1 segment
   --    and assign it to a table that can be serialized in JSON
   --    per the spec for the API.
   -- b) send the information to the kin API endpoint
   -- c) assign the function to the pt namespace
   -- d) create help function documentation for each
   
   -- In the main module, cycle through the NK1 segments and send them to the API
   -- using the shared functions you created.
   
   if MsgOut.MSH[9][2]:nodeValue() == 'A29' then

      local delQuery, delResponse, delHeaders = pt.deletePatient(mrn)
      trace (delQuery, delResponse, delHeaders)

   else
      
      local pQueryBody = pt.parsePatientData(MsgOut.PID)
      local pQuery, pResponse, pHeaders = pt.submitPatientRecord(pQueryBody,mrn)

      local addyQueryBody = pt.parsePatientAddress(MsgOut.PID)
      local addyQuery, addyResponse, addyHeaders = pt.submitPatientAddress(addyQueryBody,mrn)
      
      local gpQueryBody, gpResposeBody, gpHeaders = pt.getPatientRecord(mrn)
      
      for x=1, #MsgOut.NK1 do
         local kin = parseRelative(MsgOut.NK1[x])
         local kinQuery, kinResponse, kinHeaders = submitRelative(kin,mrn)
      end
      
      trace (pQuery, pResponse, pHeaders)
      trace (addyQuery,addyResponse, addyHeaders)
  
      end
end

