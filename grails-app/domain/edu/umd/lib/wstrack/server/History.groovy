package edu.umd.lib.wstrack.server

import java.util.regex.Matcher
import java.util.regex.Pattern
import java.util.regex.PatternSyntaxException

import edu.umd.lib.wstrack.server.History;

class History {

  Date timestamp = new Date()
  String ip
  String status
  String hostName
  String os
  String userHash
  Boolean guestFlag

  static mapping = { version false }

  static constraints = { ip(blank:false) }
 
}
