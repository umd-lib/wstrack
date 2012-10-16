package edu.umd.lib.wstrack.server



class History {

  Date timestamp = new Date()
  String computerName
  String status
  String os
  String userName
  Boolean guestFlag

  static mapping = { version false }

  static constraints = { computerName(blank:false) }
}
