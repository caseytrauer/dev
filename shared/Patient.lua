-- How to read a whole file

-- get a file handle
local f = io.open('/Users/ctrauer/Documents/Iguana6/fhir.json/patient.xsd')
-- read the whole file
local xsd = f:read('*a')
-- close the file handle
trace (xsd)

f:close()

