// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: [
    'text/html',
    'application/xhtml+xml'
  ],
  xml: [
    'text/xml',
    'application/xml'
  ],
  text: 'text/plain',
  js: 'text/javascript',
  rss: 'application/rss+xml',
  atom: 'application/atom+xml',
  css: 'text/css',
  csv: 'text/csv',
  all: '*/*',
  json: [
    'application/json',
    'text/json'
  ],
  form: 'application/x-www-form-urlencoded',
  multipartForm: 'multipart/form-data'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = [
  '/images/*',
  '/css/*',
  '/js/*',
  '/plugins/*'
]


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
  development {
    grails.logging.jul.usebridge = true
	grails.converters.default.pretty.print = true
  }
  production {
    grails.logging.jul.usebridge = false
    // TODO: grails.serverURL = "http://www.changeme.com"
  }
}

// log4j configuration
log4j = {
  // Example of changing the log pattern for the default console
  // appender:
  //
  appenders {
    rollingFile name: "stacktrace", maxFileSize: 1024, file: "./logs/wstrack-stacktrace.log"
  }

  error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
      'org.codehaus.groovy.grails.web.pages', //  GSP
      'org.codehaus.groovy.grails.web.sitemesh', //  layouts
      'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
      'org.codehaus.groovy.grails.web.mapping', // URL mapping
      'org.codehaus.groovy.grails.commons', // core / classloading
      'org.codehaus.groovy.grails.plugins', // plugins
      'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
      'org.springframework',
      'org.hibernate',
      'net.sf.ehcache.hibernate'
}

edu.umd.lib.wstrack.server.locationMap = [
	MCK1F:[location:'McKeldin Library 1st floor', regex:~/(?i)^LIBWKMCK[PM]1F[0-9]+$/],
	MCK2F:[location:'McKeldin Library 2nd floor',regex:~/(?i)^LIBWKMCK[PM]2F[0-9]+$/],
	MCK4F:[location:'McKeldin Library 4th floor',regex:~/(?i)^LIBWKMCK[PM]4F[0-9]+$/],
	MCK5F:[location:'McKeldin Library 5th floor',regex:~/(?i)^LIBWKMCK[PM]5F[0-9]+$/],
	MCK6F:[location:'McKeldin Library 6th floor',regex:~/(?i)^LIBWKMCK[PM]6F[0-9]+$/],
	MCK6F1:[location:'McKeldin Library 6th floor RM 6101',regex:~/(?i)^LIBWKMCK[PM]6F1[0-9]+$/],
	MCK6F3:[location:'McKeldin Library 6th floor RM 6103',regex:~/(?i)^LIBWKMCK[PM]6F3[0-9]+$/],
	MCK6F7:[location:'McKeldin Library 6th floor RM 6107',regex:~/(?i)^LIBWKMCK[PM]6F7[0-9]+$/],
	MCK7F:[location:'McKeldin Library 7th floor',regex:~/(?i)^LIBWKMCK[PM]7F[0-9]+$/],
	EPL1F:[location:'Engineering Library 1st floor',regex:~/(?i)^LIBWKEPL[PM]1F[0-9]+$/],
	EPL2F:[location:'Engineering Library 2nd floor',regex:~/(?i)^LIBWKEPL[PM]2F[0-9]+$/],
	EPL3F:[location:'Engineering Library 3rd floor',regex:~/(?i)^LIBWKEPL[PM]3F[0-9]+$/],
	CHM1F:[location:'Chemistry Library 1st floor',regex:~/(?i)^LIBWKCHM[PM]1F[0-9]+$/],
	CHM2F:[location:'Chemistry Library 2nd floor',regex:~/(?i)^LIBWKCHM[PM]2F[0-9]+$/],
	CHM3F:[location:'Chemistry Library 3rd floor',regex:~/(?i)^LIBWKCHM[PM]3F[0-9]+$/],
	NON1F:[location:'Nonprint Library 1st floor',regex:~/(?i)^LIBWKNON[PM]1F[0-9]+$/],
	MDR1F:[location:'MARYLANDIA',regex:~/(?i)^LIBWKMDR[PM]1F[0-9]+$/],
	PAL1F:[location:'PAL 1st floor',regex:~/(?i)^LIBWKPAL[PM]1F[0-9]+$/],
	PAL2F:[location:'PAL 2nd floor',regex:~/(?i)^LIBWKPAL[PM]2F[0-9]+$/],
	ART1F:[location:'Art Library 1st floor',regex:~/(?i)^LIBWKART[PM]1F[0-9]+$/],
	ARC1F:[location:'Arch Library',regex:~/(?i)^LIBWKARC[PM]1F[0-9]+$/]
]