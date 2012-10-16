package edu.umd.lib.wstrack.server



class Current {

  Date timestamp = new Date()
  String computerName
  String status
  String os
  String userName
  Boolean guestFlag

  static mapping = { version false }

  static constraints = {
    computerName(blank:false, unique:true)
    status(blank:false)
    os(blank:false)
    userName(blank:false)
    guestFlag(blank:false)
  }
}
