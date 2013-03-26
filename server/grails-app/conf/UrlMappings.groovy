class UrlMappings {

  static mappings = {
	  
    "/$controller/$action?/$id?"{ constraints {
        // apply constraints here
      } }

    "/track/$computerName/$status/$os/$userName"(controller: "track", action: "track")

	"/map"(controller:"libraryMap", action:"index")
	
    "/"(controller:"admin", action:"redirectindex")
    "500"(view:'/error')
  }
}