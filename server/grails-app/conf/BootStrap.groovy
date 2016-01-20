import au.com.bytecode.opencsv.CSVReader
import edu.umd.lib.wstrack.marshallers.JsonCustomMarshaller
import edu.umd.lib.wstrack.marshallers.XmlCustomMarshaller
import edu.umd.lib.wstrack.server.TrackController
import grails.converters.JSON
import grails.converters.XML
import grails.util.Environment
import org.codehaus.groovy.grails.web.converters.marshaller.xml.CollectionMarshaller
import org.codehaus.groovy.grails.web.json.JSONWriter

class BootStrap {

  def init = { servletContext ->
	  
	  println("Registering Marshaller...")
	  JSON.createNamedConfig("JsonCustomMarshaller") {
	  	it.registerObjectMarshaller(new JsonCustomMarshaller())
	  }
	  XML.createNamedConfig("XmlCustomMarshaller") {
	    it.registerObjectMarshaller(new XmlCustomMarshaller())
	  }
		
	  if (Environment.isDevelopmentMode()) {
//	  loadAndTrack()
	  loadDataFromFile()
	}
  }
  
  def loadDataFromFile(){
	  
	  println ("Loading sample data from file..." )
	  Map params = [:]
	  CSVReader reader = new CSVReader(new FileReader("current-2014-04-29.csv"));
	  String [] nextLine;
	  int counter = 0
	  while ((nextLine = reader.readNext()) != null) {
		  //INcrement the count by 1 for every new line.
		  counter++

		  if(counter==1){
			  //Skip this iteration since this is the header
			  continue
		  }else{
		  params.os = nextLine[3].toString()
		  params.status =nextLine[4].toString()
		  params.computerName = nextLine[1].toString()
		  params.userHash = nextLine[6].toString()
		  params.guestFlag = nextLine[2].toString()
		  params.timeStamp = nextLine[5].toString()
		  
		  TrackController.trackX(params)

		  }
	  }
  }
  
  def loadAndTrack(){
	  println ("Loading sample data..." )
	  Map params = [:]
	  def librarylist = ["MCK", "LMS","PAL","EPL","CHM","ARC","ART","MDR"]
	  def osList = ["P","M"]
	  def floorList = ["1F","2F","3F","4F","5F","6F","6F3","6F1","6F7"]
	  def statusList = ["login","logout"]
	  Random r =null;
	  def compName
	  for (i in 0..999) {
		  compName=''
		  r=new Random();
		compName= 'LIBRWK' + librarylist[r.nextInt(librarylist.size)]
		params.os = osList[r.nextInt(osList.size)]
		params.status = statusList[r.nextInt(statusList.size)]
		params .userName = ((i % 17 == 0) ? 'libguest' : '') + 'userName' + (i % 23)
		params.computerName = compName+params.os+floorList[r.nextInt(floorList.size)]+new Random().nextInt(20)+'a'
		TrackController.trackX(params)
	  }
	  params.userName= 'libguestuserName0'
	  params.status='login'
	  TrackController.trackX(params)
  }
  
  
  def destroy = {
  }
  
}
