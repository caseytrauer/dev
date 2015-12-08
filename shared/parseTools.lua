pt = {}
   
function parsePatientData(PID)
   
   -- start building 
   local person = {}
   local name = {}
   name.last = PID[5][1][1][1]
   name.first = PID[5][1][2]
   person.name = name
   
   local id = {}
   id.mrn = PID[3][1][1]
   id.ssn = PID[19]
   id.act = PID[18][1]   

   person.id = id
      
   person.sex = PID[8]
   person.race = PID[10][1][1]
   person.dob = PID[7][1]
   
   local record = json.serialize{data=person}
   return record
   
   end

function parsePatientAddress(PID)
   local person = {}
   local address = {}
   address.street = PID[11][1][1][1]
   address.city = PID[11][1][3]
   address.state = PID[11][1][4]
   address.zip = PID[11][1][5]
   person.address = address
   
   local record = json.serialize{data=person}
   return record
end

function parseRelative(NK)
   local person = {}
   local name = {}
   name.first = NK[2][1][2]
   name.last = NK[2][1][1][1]
   person.name = name 
   person.relationship = NK[3][1]
   
   local record = json.serialize{data=person}
   return record
end

function submitRelative(queryBody, guid)
      local query, response, headers = net.http.post{
      url= WEB_API_URL .. 'kin/' .. guid,
      headers={['Content-type']='text/json'},
      auth={username='admin',password='password'},
      body=queryBody,
      live=true}
   trace (query)
   return query, response, headers
end

function submitPatientRecord(queryBody, guid)
      local query, response, headers = net.http.post{
      url= WEB_API_URL .. 'patients/' .. guid,
      headers={['Content-type']='text/json'},
      auth={username='admin',password='password'},
      body=queryBody,
      live=true}
   trace (query)
   return query, response, headers
end

function submitPatientAddress(queryBody, guid)
      local query, response, headers = net.http.post{
      url= WEB_API_URL .. 'addresses/' .. guid,
      headers={['Content-type']='text/json'},
      auth={username='admin',password='password'},
      body=queryBody,
      live=true}
   trace (query)
   return query, response, headers
end

function getPatientRecord(guid)
      local query, response, headers = net.http.get{
      url= WEB_API_URL .. 'patients/' .. guid,
      headers={['Content-type']='text/json'},      
      auth={username='admin',password='password'},
      live=true}
   trace (query)
   return query, response, headers
end

function deletePatient(guid)
      local query, response, headers = net.http.delete{
      url= WEB_API_URL .. 'patients/' .. guid,
      headers={['Content-type']='text/json'},
      auth={username='admin',password='password'},
      live=true}
   trace (query)
   return query, response, headers
end

-- ## BUILD THE PT OBJECT NAMESPACE

pt.parsePatientData = parsePatientData
pt.parsePatientAddress = parsePatientAddress

pt.submitPatientRecord = submitPatientRecord
pt.getPatientRecord = getPatientRecord

pt.submitPatientAddress = submitPatientAddress
pt.deletePatient = deletePatient


-- ## HELP FOR THE FUNCTIONS

if help then
   
   ------------------------
   -- parsePatientData()
   ------------------------
   local h = help.example()
   h.Title = 'parsePatientData'
   h.Desc = 'Extract/format patient demo fields from PID segment of ADT messages.'
   h.Usage = 'parsePatientData(MsgOut.PID)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='JSON array of relevant patient data in PID'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=parsePatientData, help_data=h}
   
   ------------------------
   -- parsePatientAddress()
   ------------------------
   local h = help.example()
   h.Title = 'parsePatientAddress'
   h.Desc = 'Extract/format address fields from PID segment of ADT messages.'
   h.Usage = 'parsePatientAddress(MsgOut.PID)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='JSON array of relevant address data in PID'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=parsePatientAddress, help_data=h}
   
   ------------------------
   -- submitPatientRecord()
   ------------------------
   local h = help.example()
   h.Title = 'submitPatientRecord'
   h.Desc = 'Submit query to update patient record.'
   h.Usage = 'submitPatientRecord(MsgOut.PID,mrn)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='HTTP query, response code and headers.'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=submitPatientRecord, help_data=h}
 
    ------------------------
 --   getPatientRecord()
   ------------------------
   local h = help.example()
   h.Title = 'getPatientRecord'
   h.Desc = 'Query for patient demo for existing record.'
   h.Usage = 'getPatientRecord(mrn)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='HTTP query, response code and headers.'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=getPatientRecord, help_data=h}

   
   ------------------------
   -- submitPatientAddress()
   ------------------------
   local h = help.example()
   h.Title = 'submitPatientAddress'
   h.Desc = 'Submit query to update address record.'
   h.Usage = 'submitPatientAddress(MsgOut.PID,mrn)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='HTTP query, response code and headers.'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=submitPatientAddress, help_data=h}
   
   
      ------------------------
   -- deletePatient()
   ------------------------
   local h = help.example()
   h.Title = 'deletePatient'
   h.Desc = 'Submit query to delete patient and related records.'
   h.Usage = 'deletePatient(mrn)'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='HTTP query, response code and headers.'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
     This is where you would put code samples.
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=deletePatient, help_data=h}
   
end





   return pt
