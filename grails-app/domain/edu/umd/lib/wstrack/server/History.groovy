package edu.umd.lib.wstrack.server


class History {

  Date timestamp = new Date()
  String computerName
  String status
  String os
  String userHash
  Boolean guestFlag

  static mapping = { version false }

  static constraints = {
    computerName(blank:false)
    status(blank:false)
    os(blank:false)
    userHash(blank:false)
    guestFlag(blank:false)
  }

  static List listOs() {
    return withCriteria {
      projections { distinct("os") }
      order("os","asc")
    }
  }
}
