package edu.umd.lib.wstrack.server


class Current {

  Date timestamp = new Date()
  String computerName
  String status
  String os
  String userHash
  Boolean guestFlag
  String location

  static mapping = { version false }

  static constraints = {
    computerName(blank:false, unique:true)
    status(blank:false)
    os(blank:false)
    userHash(blank:false)
    guestFlag(blank:false)
	location(blank:false)
  }

  static List listOs() {
    return withCriteria {
      projections { distinct("os") }
      order("os","asc")
    }
  }

  static def listStatus() {
    return ['login', 'logout']
  }

  static def listGuestFlag() {
    return [false, true]
  }

  static Map counts() {
    Map r = [:].withDefault { [:].withDefault { [:].withDefault { 0l } } }

    listOs().each { os ->
      listStatus().each { status ->
        listGuestFlag().each { guestFlag ->
          def c = Current.countByOsAndStatusAndGuestFlag(os, status, guestFlag)

          r[os][status][guestFlag] = c
          r[os][status]['all'] += c
          r[os]['all'][guestFlag] += c
          r[os]['all']['all'] += c
          r['all'][status][guestFlag] += c
          r['all'][status]['all'] += c
          r['all']['all'][guestFlag] += c
          r['all']['all']['all'] += c
        }
      }
    }

    return r
  }

}
