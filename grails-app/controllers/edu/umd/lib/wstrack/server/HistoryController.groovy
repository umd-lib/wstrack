package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException

class HistoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    // injections
    def filterPaneService
    def exportService
    def grailsApplication

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        if(params?.format && params.format != "html") {
          export()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [historyInstanceList: History.list(params), historyInstanceTotal: History.count(), exportParams: getExportParams(params)]
    }

    def filter = {
        if(params?.format && params.format != "html") {
          export()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        render( view:'list',
          model:[ historyInstanceList: filterPaneService.filter( params, History ),
          historyInstanceTotal: filterPaneService.count( params, History ),
          filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
          params:params,
          exportParams: getExportParams(params) ] )
    }

    static def getExportParams(params) {

      Map exportParams = params.clone()

      exportParams.remove('max')
      exportParams.remove('offset')
      exportParams.remove('filter')

      return exportParams
    }

    def export = {
      response.contentType = grailsApplication.config.grails.mime.types[params.format]
      response.setHeader("Content-disposition", "attachment; filename=wstrack.${params.extension}")


      List fields = ["timestamp", "computerName", "status", "os", "userHash", "guestFlag"]
      Map labels = ["timestamp":"Timestamp", "computerName":"Computer Name", "status":"Status", "os":"OS", "userHash":"User Hash", "guestFlag":"Guest Flag"]

      def upperCase = { domain, value ->
        return value.toUpperCase()
      }

      //Map formatters = [author: upperCase]
      Map parameters = [title: "Workstation Tracking", "column.widths": [25.0, 20.0, 8.0, 20.0, 30.0, 10.0]]
      Map formatters = [:]

      exportService.export(params.format, response.outputStream, filterPaneService.filter( params, History ), fields, labels, formatters, parameters)
    }

    def create() {
        [historyInstance: new History(params)]
    }

    def save() {
        def historyInstance = new History(params)
        if (!historyInstance.save(flush: true)) {
            render(view: "create", model: [historyInstance: historyInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'history.label', default: 'History'), historyInstance.id])
        redirect(action: "show", id: historyInstance.id)
    }

    def show() {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "list")
            return
        }

        [historyInstance: historyInstance]
    }

    def edit() {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "list")
            return
        }

        [historyInstance: historyInstance]
    }

    def update() {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (historyInstance.version > version) {
                historyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'history.label', default: 'History')] as Object[],
                          "Another user has updated this History while you were editing")
                render(view: "edit", model: [historyInstance: historyInstance])
                return
            }
        }

        historyInstance.properties = params

        if (!historyInstance.save(flush: true)) {
            render(view: "edit", model: [historyInstance: historyInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'history.label', default: 'History'), historyInstance.id])
        redirect(action: "show", id: historyInstance.id)
    }

    def delete() {
        def historyInstance = History.get(params.id)
        if (!historyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "list")
            return
        }

        try {
            historyInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'history.label', default: 'History'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
