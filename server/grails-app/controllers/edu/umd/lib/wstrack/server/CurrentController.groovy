package edu.umd.lib.wstrack.server

import org.springframework.dao.DataIntegrityViolationException

class CurrentController {

	def dataSource
	
	def filterPaneService
	def grailsApplication
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
		redirect(action: "list", params: params)
	}

	def list() {
		if(params.order == null && params.sort == null) {
			params.sort = "timestamp"
			params.order = "desc"
		}
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[currentInstanceList: Current.list(params), currentInstanceTotal: Current.count(), exportParams:getExportParams(params)]
	}

	def filter = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		render( view:'list',
				model:[ currentInstanceList: filterPaneService.filter( params, Current ),
					currentInstanceTotal: filterPaneService.count( params, Current ),
					filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
					params:params,
					exportParams:getExportParams(params) ] )
	}
	
	static def getExportParams(params) {

		Map exportParams = params.clone()

		exportParams.remove('max')
		exportParams.remove('offset')
		exportParams.remove('filter')

		return exportParams
	}

	def create() {
		[currentInstance: new Current(params)]
	}

	def save() {
		def currentInstance = new Current(params)
		if (!currentInstance.save(flush: true)) {
			render(view: "create", model: [currentInstance: currentInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'current.label', default: 'Current'),
			currentInstance.id
		])
		redirect(action: "show", id: currentInstance.id)
	}

	def show() {
		def currentInstance = Current.get(params.id)
		if (!currentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[currentInstance: currentInstance]
	}

	def edit() {
		def currentInstance = Current.get(params.id)
		if (!currentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[currentInstance: currentInstance]
	}

	def update() {
		def currentInstance = Current.get(params.id)
		if (!currentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (currentInstance.version > version) {
				currentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'current.label', default: 'Current')]
						as Object[],
						"Another user has updated this Current while you were editing")
				render(view: "edit", model: [currentInstance: currentInstance])
				return
			}
		}

		currentInstance.properties = params

		if (!currentInstance.save(flush: true)) {
			render(view: "edit", model: [currentInstance: currentInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'current.label', default: 'Current'),
			currentInstance.id
		])
		redirect(action: "show", id: currentInstance.id)
	}

	def delete() {
		def currentInstance = Current.get(params.id)
		if (!currentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "list")
			return
		}

		try {
			currentInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'current.label', default: 'Current'),
				params.id
			])
			redirect(action: "show", id: params.id)
		}
	}

	def filteredDelete () {
		def exportParams = params.clone()

		def total = filterPaneService.count( exportParams, Current )
		def offset = 0l
		def chunk = 100l
		exportParams.max = chunk as String

		while (offset < total) {
			exportParams.offset = offset as String
			List data = filterPaneService.filter( exportParams, Current )
			// each row
			for(cur in data) {
				cur.delete()
			}
			offset += 100l
		}
		redirect(action: "list")
	}
}
