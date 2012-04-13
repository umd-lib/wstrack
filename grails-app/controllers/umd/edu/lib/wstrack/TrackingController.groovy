package umd.edu.lib.wstrack

import org.springframework.dao.DataIntegrityViolationException



class TrackingController {

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index() {
    //  redirect(action: "list", params: params)

    String url = "http://mckeldinb-13.umd.edu:8888/wstrack-client/wstrackClient/track/129.2.18.13/IFZaY/6PEjbf5DA8DqWDpWkeowM=/Mac%20OS%20X"
    String[] trackingInstance = Tracking.getQueryParams(url)
    def hostName = trackingInstance[0]
    def ip = trackingInstance[4]
    def usernameHash = trackingInstance[5]+trackingInstance[6]
    def os = trackingInstance[7]

    def dbValues = new Tracking(guestFlag: 'False', hostName: hostName,ip : ip, os: os, status: 'Login', userHash : usernameHash)
    dbValues.save()

    //      def ip = request.getParameter("")
    render trackingInstance

  }

  def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [trackingInstanceList: Tracking.list(params), trackingInstanceTotal: Tracking.count()]
  }

  def create() {
    [trackingInstance: new Tracking(params)]
  }

  def save() {
    def trackingInstance = new Tracking(params)
    if (!trackingInstance.save(flush: true)) {
      render(view: "create", model: [trackingInstance: trackingInstance])
      return
    }

    flash.message = message(code: 'default.created.message', args: [
      message(code: 'tracking.label', default: 'Tracking'),
      trackingInstance.id
    ])
    redirect(action: "show", id: trackingInstance.id)
  }

  def show() {
    def trackingInstance = Tracking.get(params.id)
    if (!trackingInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    [trackingInstance: trackingInstance]
  }

  def edit() {
    def trackingInstance = Tracking.get(params.id)
    if (!trackingInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    [trackingInstance: trackingInstance]
  }

  def update() {
    def trackingInstance = Tracking.get(params.id)
    if (!trackingInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    if (params.version) {
      def version = params.version.toLong()
      if (trackingInstance.version > version) {
        trackingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
            [
              message(code: 'tracking.label', default: 'Tracking')]
            as Object[],
            "Another user has updated this Tracking while you were editing")
        render(view: "edit", model: [trackingInstance: trackingInstance])
        return
      }
    }

    trackingInstance.properties = params

    if (!trackingInstance.save(flush: true)) {
      render(view: "edit", model: [trackingInstance: trackingInstance])
      return
    }

    flash.message = message(code: 'default.updated.message', args: [
      message(code: 'tracking.label', default: 'Tracking'),
      trackingInstance.id
    ])
    redirect(action: "show", id: trackingInstance.id)
  }

  def delete() {
    def trackingInstance = Tracking.get(params.id)
    if (!trackingInstance) {
      flash.message = message(code: 'default.not.found.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "list")
      return
    }

    try {
      trackingInstance.delete(flush: true)
      flash.message = message(code: 'default.deleted.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
      flash.message = message(code: 'default.not.deleted.message', args: [
        message(code: 'tracking.label', default: 'Tracking'),
        params.id
      ])
      redirect(action: "show", id: params.id)
    }
  }
}
