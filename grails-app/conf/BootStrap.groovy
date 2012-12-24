import edu.umd.lib.wstrack.server.TrackController
import grails.util.Environment

class BootStrap {

  def init = { servletContext ->
    if (Environment.isDevelopmentMode()) {

      log.info( "Loading sample data..." )

      Map params = [:]

      for (i in 0..999) {
        params.computerName = 'computerName' + (i % 11)
        params.os = 'os' + (i % 5)
        params.status = ((i % 2) ? 'login' : 'logout')
        params .userName = ((i % 17 == 0) ? 'libguest' : '') + 'userName' + (i % 23)

        TrackController.trackX(params)
      }
    }
  }
  def destroy = {
  }
}
