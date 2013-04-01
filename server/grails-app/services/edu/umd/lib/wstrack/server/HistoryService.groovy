

package edu.umd.lib.wstrack.server

import groovy.sql.Sql
import groovy.transform.WithReadLock

import javax.servlet.http.HttpServletResponse

import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

class HistoryService {
	
	def dataSource
	def grailsApplication

	@WithReadLock
    def exportService(String startDate, String endDate , String exportFile,  HttpServletResponse response) {
//			println params
			if(startDate != null && endDate != null) {
				DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
				def date = formatter.parseDateTime(startDate)
				def date2 = formatter.parseDateTime(endDate)
				def sql = new Sql(dataSource)
				def exportFilePath = "/tmp/wstrack.csv"
				if(exportFile != null) {
					exportFilePath = exportFile
				}
				
	//			def fileName = java.util.UUID.randomUUID().toString()
	//			def file = new File(exportFilePath,fileName)
				
				def file = new File(exportFilePath)
				sql.execute("select dmp(text('" + formatter.print(date) + "'), text('" + formatter.print(date2) + "'), text('" + file.getAbsolutePath() + "'))")
				
				response.contentType = grailsApplication.config.grails.mime.types['csv']
				response.setHeader("Content-disposition", "attachment; filename=wstrack.csv")
				response.outputStream << file.text
				response.outputStream.flush()
				
				
	//			sql.execute("COPY (Select * from History where timestamp >= to_timestamp('" + formatter.print(date) +
	//				"', 'yyyy-mm-dd hh24:mi:ss') and timestamp <= to_timestamp('" + formatter.print(date2) + "', 'yyyy-mm-dd hh24:mi:ss')) TO STDOUT") //\'" + exportFilePath + "\' DELIMITER AS \',\'")
		}
	}
    
}
