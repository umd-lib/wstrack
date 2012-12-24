import edu.umd.lib.wstrack.server.TrackController
import grails.util.Environment

class BootStrap {

  def init = { servletContext ->
    if (Environment.isDevelopmentMode()) {

      log.info( "Loading sample data..." )

      Map params = [:]

      for (i in 1..1000) {
        params.computerName = 'computerName' + (i % 10)
        params.os = 'os' + (i % 3)
        params.status = ((i % 3 in [1,2]) ? 'login' : 'logout')
        params .userName = ((i % 15 == 0) ? 'libguest' : '') + 'userName' + (i % 20)

        TrackController.trackX(params)
      }
    }
  }
  def destroy = {
  }
}
