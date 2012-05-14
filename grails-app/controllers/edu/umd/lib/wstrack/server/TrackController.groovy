package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import edu.umd.lib.wstrack.server.Current;

class TrackController {

  static allowedMethods = [track: "GET"]

  def index() {
    redirect(action: "list", params: params)
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
      //def userHash = params.userHash.decodeURL()
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
      //def trackInstance = Current.get(params.id)
      return [currentInstance : currentInstance]

    }
    else {
      params.status = 'error'
      render 'Invalid status. Status should be either login or logout.'
    }

  }

  def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [currentInstanceList: Current.list(params), currentInstanceTotal: Current.count()]
  }

  def create() {
    [currentInstance: new Current(params)]
  }

  def save() {
    def currentInstance = new Current(params)
    if (!currentInstance.save(flush: true)) {
      render(view: "create", model: [currentInstance: currentInstance])
      return
    }

    flash.message = message(code: 'default.created.message', args: [
      message(code: 'current.label', default: 'Current'),
      currentInstance.id
    ])
    redirect(action: "show", id: currentInstance.id)
  }

  def show() {
    def currentInstance = Current.get(params.id)
    if (!currentInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    [currentInstance: currentInstance]
  }

  def edit() {
    def currentInstance = Current.get(params.id)
    if (!currentInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    [currentInstance: currentInstance]
  }

  def update() {
    def currentInstance = Current.get(params.id)
    if (!currentInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    if (params.version) {
      def version = params.version.toLong()
      if (currentInstance.version > version) {
        currentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
            [
              message(code: 'current.label', default: 'Current')]
            as Object[],
            "Another user has updated this Current while you were editing")
        render(view: "edit", model: [currentInstance: currentInstance])
        return
      }
    }

    currentInstance.properties = params

    if (!currentInstance.save(flush: true)) {
      render(view: "edit", model: [currentInstance: currentInstance])
      return
    }

    flash.message = message(code: 'default.updated.message', args: [
      message(code: 'current.label', default: 'Current'),
      currentInstance.id
    ])
    redirect(action: "show", id: currentInstance.id)
  }

  def delete() {
    def currentInstance = Current.get(params.id)
    if (!currentInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    try {
      currentInstance.delete(flush: true)
      flash.message = message(code: 'default.deleted.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
      flash.message = message(code: 'default.not.deleted.message', args: [
        message(code: 'current.label', default: 'Current'),
        params.id
      ])
      redirect(action: "show", id: params.id)
    }
  }

}
