package edu.umd.lib.wstrack.marshallers;

import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller;

import grails.converters.XML;

public class XmlCustomMarshaller implements ObjectMarshaller<XML>{
	  @Override
	  public boolean supports(Object object) {
		  object instanceof Map
	  }
	  
//		@Override
//		String getElementName(final Object o) {
//			'availability'
//		}
	  
	  @Override
	  public void marshalObject(Object object, XML converter) {
		  Map foo = object as Map
		  
		  converter.startNode("availability")
		  converter.attribute("action", "list")
		  
		  for(locVsCountFinalMap in foo){
			  
			  for(fullLocationNameMap in locVsCountFinalMap.value){
				  converter.startNode("location")
				  converter.attribute("name", fullLocationNameMap.key)
				  
				  for(locationSymbolMap in fullLocationNameMap.value){
					  converter.attribute("key", locationSymbolMap.key)

					  //For every workstation
					  for(workstationMap in locationSymbolMap.value){
						  converter.startNode("workstation")
						  converter.attribute("type", workstationMap.key)
						  
						  //For every pc or mac the total and available attr.
						  for(totalAvailMap in workstationMap.value){
							  converter.attribute(totalAvailMap.key,totalAvailMap.value.toString())
						  }
						  
						  converter.end()
					  }
				  }
				  converter.end()
			  }
		  }
		  converter.end()
	  }
	}
