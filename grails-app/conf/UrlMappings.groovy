class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{ constraints { // apply constraints here
      } }

    "/track/$computerName/$status/$os/$guestFlag/$userName**"(controller: "track", action: "track")

    "/"(controller:"admin", action:"redirectindex")
    "500"(view:'/error')
  }
}