class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
        // apply constraints here
      }
    }

    "/track/$ip/$status/$hostName/$os/$userHash/$guestFlag"(controller: "track", action: "track")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
