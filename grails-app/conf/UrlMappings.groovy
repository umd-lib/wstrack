class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
        // apply constraints here
      }
    }

    "/track/$ip/$status/$hostName/$os/$userHash/$guestFlag"(controller: "track", action: "track")

    "/"(controller:"admin", action:"redirectindex")
    "500"(view:'/error')
  }
}
