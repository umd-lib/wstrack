package edu.umd.lib.wstrack.server
import java.util.regex.*

import javax.xml.transform.Result

import au.com.bytecode.opencsv.CSVReader
import grails.converters.JSON
import grails.converters.XML

/**
 * 
 * @author hatlesh
 *
 */
class AvailabilityController {

	static final PATTERNMAC = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)M[1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'
	static final PATTERNPC = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)P[1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'
	static final PATTERN = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'

	def list() {

		//Filter out non standard names
		def matchedAllCurrentList= []
		matchedAllCurrentList=getAllMatchedCurrentList();

		//This gives the total count of all the systems with standard name.
		def totalCount = matchedAllCurrentList.size();

		//Filter out all available system available and their count
		def currentAvailableList = []
		def currentAvailableCount = 0;
		currentAvailableList = getAllAvailableSystems(matchedAllCurrentList)
		currentAvailableCount = currentAvailableList.size()

		def retSymMap=getSymVsLocationMap()

		def locationVsCurrentMap = new HashMap<String,ArrayList<Current>>() //Map that stores the location vs the list of all the systems at that location
		locationVsCurrentMap=getLocationsVsCurrentMap(matchedAllCurrentList)

		def locationVsCountsMap = []
		locationVsCountsMap=getLocationVsCountsMap(locationVsCurrentMap)

		def locVsCountFinalMap = []
		locVsCountFinalMap=generateLocationNamesMap(locationVsCountsMap,retSymMap)

		def renderAs="json"
		if(null!=params.format)
			renderAs = params.format
		def result = [locVsCountFinalMap:locVsCountFinalMap]

		if(params.debug=='true'){
			def locationVsCurrentFinal = generateLocationNamesMap(locationVsCurrentMap,retSymMap)
			result = [locVsCountFinalMap:locVsCountFinalMap,locationVsCurrentFinal:locationVsCurrentFinal]
			return result

		}
		
		if(renderAs.equalsIgnoreCase("json")){
			render result as JSON
		}
		else if(renderAs.equalsIgnoreCase("xml")){
			render result as XML
		}
		else{
			return result
		}
	}
	
	

	/**
	 * This method replaces the locations with there full names 
	 * based on the retSymMap mapping between the symbols and the locations.
	 * @param locationVsCountsMap
	 * @return
	 */
	def generateLocationNamesMap(def locationVsCountsMap,def retSymMap){
		def newMap = [:]
		def tempMap
		for (locVsCountsMap in locationVsCountsMap){
			tempMap=[:]
			for(retSymbolVsLocMap in retSymMap){
				if(retSymbolVsLocMap.key == locVsCountsMap.key){
					tempMap.put(locVsCountsMap.key, locVsCountsMap.value)
					newMap.put(retSymbolVsLocMap.value, tempMap)
				}
			}
		}
		return newMap
	}

	/**
	 * This function gives the total list of current systems (Available and Not Available systems) 
	 * in all the locations.
	 * @param matchedAllCurrentList
	 * @return locationVsCurrentMap
	 */
	def getLocationsVsCurrentMap(def matchedAllCurrentList){

		def locationMap = getLocationMap();//Mapping of location vs regex
		ArrayList<Current> locCurrentList = null//Array list to hold all the systems available in a particular location
		def locationVsCurrentMap = new HashMap<String,ArrayList<Current>>() //Map that stores the location vs the list of all the systems at that location

		//For location, check all the systems that match
		for(map in locationMap){
			locCurrentList = new ArrayList<Current>()
			//check all the "valid" systems only
			for(Current tempCurr:matchedAllCurrentList){

				if(isMatch(tempCurr.getComputerName(),map.value)){
					//Create an array list of all the systems in a particular location
					locCurrentList.add(tempCurr)
				}

			}
			if(locCurrentList!=null || locCurrentList.size()!=0){
				locationVsCurrentMap.put(map.key,locCurrentList)
			}
		}

		return locationVsCurrentMap
	}

	/**
	 * This method returns a map with the available and total system counts.
	 * @param locationVsCurrentMap
	 * @return
	 */
	def getLocationVsCountsMap(def locationVsCurrentMap){
		def locationVsCountsMap = new HashMap<String,Map<String,Map<String,Integer>>>() //of the form
		//[Mck 1st floor:{Pc=[total:4,available=2],Mac=[total:4,available=2]}]
		int macCount=0
		int pcCount=0
		int availablePcCount=0
		int	availableMacCount=0

		String finder=""
		def countsMap=[]
		def osPcMap=[]
		def osMacMap=[]
		for(map in locationVsCurrentMap){
			//Reinitialize for the next iteration.
			macCount=0
			pcCount=0
			availablePcCount=0
			availableMacCount=0

			countsMap = new HashMap<String, Map<String,Integer>>()
			osPcMap = new HashMap<String,Integer>();
			osMacMap = new HashMap<String,Integer>();
			//Get total systems list
			def availableSystemsList = []
			availableSystemsList = getAllAvailableSystems(map.value)

			//Get system counts
			//iterate over each of the computer and find out the count for ALL the pcs and macs
			//irrespective of their availability
			for(Current tempCurr:map.value){
				finder=findComputerOS(tempCurr.getComputerName())

				//If the status is logout. INcrement both the counts. else just increment the total count.
				if(finder.equalsIgnoreCase("PC") && tempCurr.getStatus().equalsIgnoreCase("logout")){
					availablePcCount++
					pcCount++
				}else if(finder.equalsIgnoreCase("PC") && !tempCurr.getStatus().equalsIgnoreCase("logout")){
					pcCount++
				}else if(finder.equalsIgnoreCase("MAC") && tempCurr.getStatus().equalsIgnoreCase("logout")){
					availableMacCount++
					macCount++
				}
				else if(finder.equalsIgnoreCase("MAC") && !tempCurr.getStatus().equalsIgnoreCase("logout")){
					macCount++
				}

			}
			osPcMap.put("available", availablePcCount);
			osPcMap.put("total", pcCount);

			osMacMap.put("available", availableMacCount);
			osMacMap.put("total", macCount);

			//Populate the map with the counts
			countsMap.put("pc",osPcMap)
			countsMap.put("mac",osMacMap)
			locationVsCountsMap.put(map.key, countsMap)


		}
		return locationVsCountsMap
	}
	/**
	 * For debugging purpose
	 * @return
	 */
	def listAll(def result){
		return result
	}

	/**
	 * This function returns the OS type MAC/PC
	 * for a given computer name
	 * @param localComputerName
	 * @return
	 */
	def findComputerOS(def localComputerName){

		def match = false

		match = isMatch(localComputerName,PATTERNMAC)
		if(match){
			return "MAC"
		}else{
			match = isMatch(localComputerName,PATTERNPC)
			if(match){
				return "PC"
			}
		}
	}

	/**
	 * This method compares the string to check with the regex pattern
	 * and returns a true or false based on the match
	 * @param strToCheck = String to check
	 * @param regexPattern = Pattern used for string check without the ~/ /
	 * @return if strToCheck=regexPattern returns true else false
	 */
	def isMatch(def strToCheck, def regexPattern){
		def match = false
		def pattern = ""
		pattern = ~/${regexPattern}/
		assert pattern instanceof Pattern
		match = pattern.matcher(strToCheck).matches();
		return match
	}


	/**
	 * This class removes all the entries with non-standard computer names
	 * and then returns the COMPLETE LIST that contains ONLY the standard 
	 * computer names. 
	 * @return
	 */
	List getAllMatchedCurrentList(){

		//This fetches all the current systems.
		def currentList = Current.list();
		def pattern = ~/${PATTERN}/
		//$
		assert  pattern instanceof Pattern
		boolean match=false;
		def tempMatchList = []

		for(Current current:currentList){
			match = pattern.matcher(current.getComputerName()).matches();
			if(match){
				tempMatchList.add(current);
			}
		}

		return tempMatchList
	}

	/**
	 * This method returns the list of all the systems that are available.
	 * Since it uses the current list, which only updates the status of a system, 
	 * A system is available when the status of the system is logoff
	 * @param matchedAllCurrentList
	 * @return
	 * @Validateable
	 */

	def getAllAvailableSystems(def matchedAllCurrentList){
		def tempCurrentListByStatus = []
		//tempCurrentListByStatus =  matchedAllCurrentList.list(fetch: [status:"logout"]);
		for(Current tempCurrent:matchedAllCurrentList){
			if(tempCurrent.getStatus().equalsIgnoreCase("logout")){
				tempCurrentListByStatus.add(tempCurrent);
			}
		}
		return tempCurrentListByStatus
	}


	/**
	 * This method gets the location mapping from the Config.groovy file.
	 * It returns a map of Location vs its regex pattern
	 * @return locationMap [key as location: value as regex pattern]
	 */
	def getLocationMap(){
		
		def retLocationMap=[:]
		for (map in grailsApplication.config.edu.umd.lib.wstrack.server.locationMap){
			retLocationMap.put(map.key, map.value['regex'])
		}
		return retLocationMap
	}

	/**
	 * This function returns the symbol vs the location name map. 
	 * Eg. MCK1F=McKeldin Library 1st floor
	 * @return retSymMap
	 */
	def getSymVsLocationMap(){

		def retSymMap=[:]
		for (map in grailsApplication.config.edu.umd.lib.wstrack.server.locationMap){
			retSymMap.put(map.key, map.value['location'])
		}
		return retSymMap
	}

}
