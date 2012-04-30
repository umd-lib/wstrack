package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import edu.umd.lib.wstrack.server.Current;

class TrackController {

  static allowedMethods = [track: "GET"]

  def index() {
    render(view:'/error')
  }

  def track() {

    def result = [status: "success"]

    // Input validation
    Boolean guestFlag = (params.guestFlag == 'true')

    /*
     * @Javadoc - This is the input validation. Only if status is 'login' or 'logout' , the tables 'Current' and 'History' will get populated.
     * In all other cases, an error message for 'Invalid status' will be rendered.
     */
    if(params.status == 'login' || params.status == 'Login' || params.status == 'logout' || params.status == 'Logout') {

      // Add entry in History
      def history = new History(guestFlag: guestFlag, hostName: params.hostName,ip : params.ip, os: params.os, status: params.status, userHash : params.userHash)
      history.save()

      // Defining Current Instance which will check if a value exists in the database for a particular IP ( primary Key)
      def currentInstance = Current.findByIp(params.ip)

      if(!currentInstance) {
        // Create entry in Current
        def current = new Current(guestFlag: guestFlag, hostName: params.hostName,ip : params.ip, os: params.os, status: params.status, userHash : params.userHash)
        current.timestamp = history.timestamp
        current.save()
        result.current = current

        render result as JSON
      }
      else if(currentInstance) {
        // Update the already existing entry for that particular IP
        currentInstance.setGuestFlag(guestFlag)
        currentInstance.setHostName(params.hostName)
        currentInstance.setOs(params.os)
        currentInstance.setStatus(params.status)
        currentInstance.setUserHash(params.userHash)
        //
        currentInstance.timestamp = history.timestamp
        currentInstance.save()
        result.currentInstance = currentInstance
        render result as JSON
      }


    }
    else {
      params.status = 'error'
      render 'Invalid status. Status should be either login or logout.'
    }

  }

}
