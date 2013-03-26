package edu.umd.lib.wstrack.server



class History {

  Date timestamp = new Date()
  String computerName
  String status
  String os
  String userHash
  Boolean guestFlag

  static mapping = { version false
	  computerName column: 'computer_name', index: 'computer_name_Idx'
	  status column: 'status', index: 'status_Idx'
	  os column: 'os', index: 'os_Idx'
	  userHash column: 'user_hash', index: 'user_hash_Idx'
	  guestFlag column: 'guest_flag', index: 'guest_flag_Idx'
	  timestamp column: 'timestamp', index: 'timestamp_Idx'
  }

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
          def c = History.countByOsAndStatusAndGuestFlag(os, status, guestFlag)

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
