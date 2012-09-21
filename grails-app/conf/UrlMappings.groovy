class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{ constraints { // apply constraints here
      } }

    "/track/$ip/$status/$hostName/$os/$guestFlag/$userHash**"(controller: "track", action: "track")

    "/"(controller:"admin", action:"redirectindex")
    "500"(view:'/error')
  }
}