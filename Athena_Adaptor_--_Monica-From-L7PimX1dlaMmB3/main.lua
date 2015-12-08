-- The main function is the first function called from Iguana.
-- for some reason the requests are saying bad authorization. trying to fix it.
-- Before using the Athena Adapter, please enter your consumer key and consumer secret into the config file.
require 'api'
config = require 'config'

function main()
   local Connection = athena.connect{username=config.username, password=config.password, cache=true}
   --Connection.administrative.customfields.read{}
   --Connection.appointments.appointmenttypes.appointmenttypeid.read{practiceid=195900}
   Connection.administrative.providers.read{practiceid=195900}
   
end


















