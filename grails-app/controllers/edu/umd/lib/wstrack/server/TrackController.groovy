package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import edu.umd.lib.wstrack.server.Current;

class TrackController {

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def track() {

    def result = [status: "success"]

    // Input validation
    Boolean guestFlag = (params.guestFlag == 'true')

    // Add entry in History
    def history = new History(guestFlag: guestFlag, hostName: params.hostName,ip : params.ip, os: params.os, status: params.status, userHash : params.userHash)
    history.save()

    // Create or Update entry in Current
    def current = new Current(guestFlag: guestFlag, hostName: params.hostName,ip : params.ip, os: params.os, status: params.status, userHash : params.userHash)
    current.timestamp = history.timestamp
    current.save()

    result.current = current

    render result as JSON

  }

}
