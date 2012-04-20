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

}
