

package edu.umd.lib.wstrack.server

import groovy.sql.Sql
import groovy.transform.WithWriteLock

import javax.servlet.http.HttpServletResponse

import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

class HistoryService {
	
	def dataSource
	def grailsApplication

	@WithWriteLock
    def exportService(String startDate, String endDate , String exportFile,  HttpServletResponse response) {
		if(startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
			DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
			def date = formatter.parseDateTime(startDate)
			def date2 = formatter.parseDateTime(endDate)
			def sql = new Sql(dataSource)
			def exportFilePath = "/tmp/wstrack.csv"
			if(exportFile != null) {
				exportFilePath = exportFile
			}
			def file = new File(exportFilePath)
			sql.execute("select dmp(text('" + formatter.print(date) + "'), text('" + formatter.print(date2) + "'), text('" + file.getAbsolutePath() + "'))")		
			response.contentType = grailsApplication.config.grails.mime.types['csv']
			response.setHeader("Content-disposition", "attachment; filename=wstrack.csv")
			response.outputStream << file.text
			response.outputStream.flush()
		}
	}
    
}
