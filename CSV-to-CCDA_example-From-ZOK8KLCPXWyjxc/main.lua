require 'section_template'
local csv = require 'csv'

-- import shared modules
local cda = require 'cda'
require 'cda.xml'
require 'cda.null'
require 'cda.codeset'

-- import local modules
require 'fillmedications'
require 'fillheader'

local addElement = node.addElement


-- The main function is the first function called from Iguana.
function main()

   -- ## IMPORT CSV FILE FROM LOCAL FOLDER
   local File = io.open("/Users/ctrauer/Documents/Iguana6Data/Demo/CSVtoCCD/medications.csv", "r")
   local medsCSV = File:read("*a")
   File:close()

   trace(medsCSV)

   -- ## PARSE CSV FILE
   local medications = csv.parseCsv(medsCSV,',')
   trace(medications)

   -- ## REORGANIZE PARSE FILE
   medications = csv.convertHeader(medications)
   trace(medications)


   -- ## THIS DEMONSTRATES BASIC TECHNIQUE FOR PARSING AN XML FILE
   local x = xml.parse{data=example_section}


   -- ## THIS USES SOME PREDEFINED MODULES TO HELP BUILD DOCUMENT
   -- Create a new CDA document
   local Doc = cda.new()
   local CD = Doc.ClinicalDocument   

   -- Add CDA Header 
   FillHeader(CD)

   -- Add CDA Body
   local Body = addElement(CD, 'component')
   local SB = addElement(Body, 'structuredBody')
   local COM = addElement(SB, 'component')

   trace(Body)

   -- Build Medication Section (using static data)
   FillMedications(COM)

   trace(Body)


   -- ## HERE IS A SIMPLER EXAMPLE OF BUILDING THE DOCUMENT.
   -- ## WE ARE GOING TO BUILD THE HTML DISPLAY SECTION
   -- ## USING A CUSTOM MapMedicationsDisplay FUNCTION.

   -- Build Medication List display (using incoming data)

   trace(CD.component.structuredBody.component.section)

   MapMedicationsDisplay(CD.component.structuredBody.component.section, medications)

   trace(CD.component.structuredBody.component.section)

   trace(CD)


   -- ## WRITE CDA TO FILE (in Iguana install dir)
   if iguana.isTest() then
      -- unformatted xml
      local f = io.open('csv2cda.xml','w+')
      f:write(tostring(Doc))
      f:close()

      -- formatted with xsl stylesheet
      f = io.open('cda_web.xml','w+')
      f:write('<?xml-stylesheet type="text/xsl" href="WebViewLayout_CDA.xsl"?>\n')
      f:write(tostring(Doc))
      f:close()
   end

end