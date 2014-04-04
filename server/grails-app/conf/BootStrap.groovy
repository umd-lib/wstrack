import edu.umd.lib.wstrack.server.TrackController
import grails.util.Environment

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
    }
  }
  def destroy = {
  }
}
