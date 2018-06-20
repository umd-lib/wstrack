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
	MCK1F:[location:'McKeldin Library 1st floor',regex:~/(?i)^LIBRWKMCK[PM]1F.*$/],
	MCK2F:[location:'McKeldin Library 2nd floor',regex:~/(?i)^LIBRWKMCK[PM]2F.*$/],
	MCK3F:[location:'McKeldin Library 3rd floor',regex:~/(?i)^LIBRWKMCK[PM]3F.*$/],
	MCK4F:[location:'McKeldin Library 4th floor',regex:~/(?i)^LIBRWKMCK[PM]4F.*$/],
	MCK5F:[location:'McKeldin Library 5th floor',regex:~/(?i)^LIBRWKMCK[PM]5F.*$/],
	MCK6F:[location:'McKeldin Library 6th floor',regex:~/(?i)^LIBRWKMCK[PM]6F1.*$/],
	MCK6F1:[location:'McKeldin Library 6th floor RM 6101',regex:~/(?i)^LIBRWKMCK[PM]6FL.*$/],
	MCK6F3:[location:'McKeldin Library 6th floor RM 6103',regex:~/(?i)^LIBRWKMCK[PM]6F3.*$/],
	MCK6F7:[location:'McKeldin Library 6th floor RM 6107',regex:~/(?i)^LIBRWKMCK[PM]6F7.*$/],
	MCK7F:[location:'McKeldin Library 7th floor',regex:~/(?i)^LIBRWKMCK[PM]7F.*$/],
	EPL1F:[location:'STEM Library 1st floor',regex:~/(?i)^LIBRWKSTEM[PM]1F.*$/],
	EPL2F:[location:'STEM Library 2nd floor',regex:~/(?i)^LIBRWKSTEM[PM]2F.*$/],
	EPL3F:[location:'STEM Library 3rd floor',regex:~/(?i)^LIBRWKSTEM[PM]3F.*$/],
	CHM1F:[location:'Chemistry Library 1st floor',regex:~/(?i)^LIBRWKCHM[PM]1F.*$/],
	CHM2F:[location:'Chemistry Library 2nd floor',regex:~/(?i)^LIBRWKCHM[PM]2F.*$/],
	CHM3F:[location:'Chemistry Library 3rd floor',regex:~/(?i)^LIBRWKCHM[PM]3F.*$/],
	LMSBF:[location:'Library Media Services Ground floor',regex:~/(?i)^LIBRWKLMS[PM]BF.*$/],
	MDR1F:[location:'MARYLANDIA',regex:~/(?i)^LIBRWKMDR[PM]1F.*$/],
	PAL1F:[location:'PAL 1st floor',regex:~/(?i)^LIBRWKPAL[PM]1F.*$/],
	PAL2F:[location:'PAL 2nd floor',regex:~/(?i)^LIBRWKPAL[PM]2F.*$/],
	ART1F:[location:'Art Library 1st floor',regex:~/(?i)^LIBRWKART[PM]1F.*$/],
	ARC1F:[location:'Arch Library',regex:~/(?i)^LIBRWKARC[PM]1F.*$/]
]
