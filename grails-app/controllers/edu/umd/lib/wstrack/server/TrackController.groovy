package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException

import edu.umd.lib.wstrack.server.Current;




class TrackController {

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def track() {

    // Input validation
    Boolean guestFlag = (params.guestFlag == 'true')
    
    def dbValues = new Current(guestFlag: guestFlag, hostName: params.hostName,ip : params.ip, os: params.os, status: params.status, userHash : params.userHash)
    dbValues.save()

    render dbValues

  }

  def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [trackingInstanceList: Current.list(params), trackingInstanceTotal: Current.count()]
  }

  def create() {
    [trackingInstance: new Current(params)]
  }

  def save() {
    def trackingInstance = new Current(params)
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
    def trackingInstance = Current.get(params.id)
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
    def trackingInstance = Current.get(params.id)
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
    def trackingInstance = Current.get(params.id)
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
    def trackingInstance = Current.get(params.id)
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
