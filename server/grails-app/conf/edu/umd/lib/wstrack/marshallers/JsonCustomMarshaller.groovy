package edu.umd.lib.wstrack.marshallers;
import grails.converters.JSON

import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller
import org.codehaus.groovy.grails.web.json.JSONWriter

public class JsonCustomMarshaller implements ObjectMarshaller<JSON>{
	@Override
	public boolean supports(Object object) {
		object instanceof Map
	}


	@Override
	public void marshalObject(Object object, JSON json) {
		def tempMap=[:]
		Map foo = object as Map
		JSONWriter writer = json.getWriter();
		for(locVsCountFinalMap in foo){
			writer.array()

			for(fullLocationNameMap in locVsCountFinalMap.value){
				//converter.property("location", fullLocationNameMap.key)
				writer.object().key("location").value(fullLocationNameMap.key.toString())

				for(locationSymbolMap in fullLocationNameMap.value){
					writer.key("key").value(locationSymbolMap.key)
					// Used by hippo
					//For every workstation
					for(workstationMap in locationSymbolMap.value){
						//writer.key("workstation_type").value(workstationMap.key)

						tempMap.put("type",workstationMap.key)
						//For every pc or mac the total and available attr.
						for(totalAvailMap in workstationMap.value){
							//writer.key(totalAvailMap.key).value(totalAvailMap.value)
							tempMap.put(totalAvailMap.key,totalAvailMap.value)
						}

						writer.key("workstation").value(tempMap)

					}

					// Used by drupal
					writer.key("workstations")
					writer.object()
					//For every workstation
					for(workstationMap in locationSymbolMap.value){
						//writer.key("workstation_type").value(workstationMap.key)

						writer.key(workstationMap.key)
						writer.object()
						//For every pc or mac the total and available attr.
						for(totalAvailMap in workstationMap.value){
							//writer.key(totalAvailMap.key).value(totalAvailMap.value)
							writer.key(totalAvailMap.key).value(totalAvailMap.value)
						}
						writer.endObject()

					}
					writer.endObject()

				}
				writer.endObject()
			}

			writer.endArray()
		}
	}
}
