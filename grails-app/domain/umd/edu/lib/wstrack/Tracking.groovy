package umd.edu.lib.wstrack

import java.util.regex.Matcher
import java.util.regex.Pattern
import java.util.regex.PatternSyntaxException




class Tracking {

  String ip
  String hostName
  String os
  String userHash
  String status
  Boolean guestFlag


  static mapping = {
    table "History"
    version false
  }

  static constraints = { ip(blank:false) }

  public static String[] getQueryParams(String url) {

    String[] urlParts = url.split("//")

    String[] urlParameters = urlParts[1].split("/")


    if (urlParts.length > 1) {
      String[] query = urlParts[1]

      for(int i=0;i<urlParameters.length; i++) {
        println urlParameters[i]
      }

      return urlParameters
    }

    def dbValues = new Tracking(guestFlag: 'False', hostName: urlParameters[0],ip : urlParameters[4], os: urlParameters[7], status: 'Login', userHash : urlParameters[5]+urlParameters[6])
    dbValues.save()
  }

  //public static Map<String, List<String>> getQueryParams(String url) {
  //  try {
  //      Map<String, List<String>> params = new HashMap<String, List<String>>()
  //      String[] urlParts = url.split("/")
  //      if (urlParts.length > 1) {
  //          String query = urlParts[1]
  //
  //          for(int i=0;i<urlParts.length; i++) {
  //            println urlParts[i]
  //
  //          }
  //         render text: ([ message: "Hello, world!", OperatingSystem: urlParts[8], Username: urlParts[6]+urlParts[7], Hostname: urlParts[1] ])
  ////          for (String param : query.split("&")) {
  ////              String[] pair = param.split("=")
  ////              String key = URLDecoder.decode(pair[0], "UTF-8")
  ////              String value = ""
  ////              if (pair.length > 1) {
  ////                  value = URLDecoder.decode(pair[1], "UTF-8")
  ////              }
  ////
  ////              List<String> values = params.get(key)
  ////              if (values == null) {
  ////                  values = new ArrayList<String>()
  ////                  params.put(key, values)
  ////              }
  ////              values.add(value)
  ////          }
  //      }
  //
  //      return params
  //  } catch (UnsupportedEncodingException ex) {
  //      throw new AssertionError(ex)
  //}
  //  }

}
