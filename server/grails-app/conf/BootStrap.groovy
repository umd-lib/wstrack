import edu.umd.lib.wstrack.server.TrackController
import grails.converters.XML
import grails.util.Environment
import org.codehaus.groovy.grails.web.converters.marshaller.xml.CollectionMarshaller

class BootStrap {

  def init = { servletContext ->
    if (Environment.isDevelopmentMode()) {

      println ("Loading sample data..." )

      Map params = [:]
	  def librarylist = ["MCK", "NON","PAL","EPL","CHM","ARC","ART","MDR"]
	  def osList = ["P","M"]
	  def floorList = ["1F","2F","3F","4F","5F","6F","6F3","6F1","6F7"]
	  def statusList = ["Login","Logout"]
	  Random r =null;
	  def compName
      for (i in 0..999) {
		  compName=''
		  r=new Random();
        compName= 'LIBWK' + librarylist[r.nextInt(librarylist.size)]
        params.os = osList[r.nextInt(osList.size)]
        params.status = statusList[r.nextInt(statusList.size)]
        params .userName = ((i % 17 == 0) ? 'libguest' : '') + 'userName' + (i % 23)
		params.computerName = compName+params.os+floorList[r.nextInt(floorList.size)]+new Random().nextInt(20)+'a'
        TrackController.trackX(params)
      }

      params.userName= 'libguestuserName0'
      params.status='login'
      TrackController.trackX(params)

	  XML.registerObjectMarshaller(new CollectionMarshaller() {
		@Override
		public boolean supports(Object object) {
			object instanceof Map
		}
		
//		@Override
//		String getElementName(final Object o) {
//			'availability'
//		}
		
		@Override
		public void marshalObject(Object object, XML converter) {
			Map foo = object as Map
			
			converter.startNode("availability")
			converter.attribute("action", "list")
			
			
			for(locVsCountFinalMap in foo){
				for(locationMap in locVsCountFinalMap.value){
					converter.startNode("location")
//					converter.attribute("key", "MCK1f")
					converter.attribute("name", locationMap.key)
					
					//For every workstation
					for(workstationMap in locationMap.value){
					
						converter.startNode("workstation")
						converter.attribute("type", workstationMap.key)
						
						//For every pc or mac the total and available attr.
						for(totalAvailMap in workstationMap.value){
							converter.attribute(totalAvailMap.key,totalAvailMap.value.toString())
//							converter.chars totalAvailMap.value
							//converter.end()
						}
						
						converter.end()
					}	
					converter.end()
				}
			}
			converter.end()
			
	
		}
	  })
	}
  }
  def destroy = {
  }
  
}
