package edu.umd.lib.wstrack.server
import java.util.regex.*
import au.com.bytecode.opencsv.CSVReader
import grails.converters.JSON

/**
 * 
 * @author hatlesh
 *
 */
class AvailabilityController {

	static final FILE_PATH = "/apps/git/wstrack/server/location_map.csv"
	static final PATTERNMAC = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)M[1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'
	static final PATTERNPC = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)P[1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'
	static final PATTERN = '^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7]F(1|3|7)?[0-9]+[a-zA-Z]$'

	def listAvailable() {

		//Filter out non standard names
		def matchedAllCurrentList= []
		matchedAllCurrentList=getAllMatchedCurrentList();

		//Set Locations for the system.
		//setLocations(matchedAllCurrentList)

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

		def renderAs="JSON"
		if(null!=params.format)
			renderAs = params.format
		//def result = [locVsCountFinalMap:locVsCountFinalMap,locationVsCurrentMap:locationVsCurrentMap,locationVsCountsMap:locationVsCountsMap,retSymMap:retSymMap]
		def result = [locVsCountFinalMap:locVsCountFinalMap]
		
		if(params.debug=='true'){
			def locationVsCurrentFinal = generateLocationNamesMap(locationVsCurrentMap,retSymMap)
			result = [locVsCountFinalMap:locVsCountFinalMap,locationVsCurrentFinal:locationVsCurrentFinal]	
			
		}
		
		if(renderAs == 'JSON'){
			render result as JSON
		}
		//		 else if(renderAs=='XML'){
		//			render(text:"<xml>some xml</xml>",contentType:"text/xml",encoding:"UTF-8")
		//		}
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
		for (locVsCountsMap in locationVsCountsMap){
			for(retSymbolVsLocMap in retSymMap){
				if(retSymbolVsLocMap.key == locVsCountsMap.key){
					newMap.put(retSymbolVsLocMap.value, locVsCountsMap.value)
					print "hello"
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

		def locationMap = getLocationMappingFromCSV();//Mapping of location vs regex
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
			//Clear the locCurrentList for the next location
			//locCurrentList.clear()
		}

		return locationVsCurrentMap
	}

	/**
	 * This method returns a map with the available and total system counts.
	 * @param locationVsCurrentMap
	 * @return
	 */
	def getLocationVsCountsMap(HashMap<String,ArrayList<Current>> locationVsCurrentMap){
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
	 * This method updates the location for the list of current
	 * systems.
	 * @param tempList
	 */
	void setLocations(def tempList){
		def loc = ""
		for(Current curr:tempList){

			loc = getLocation(curr.getComputerName())
			if(null!=loc || ""!=loc){
				curr.setLocation(loc)
				curr.timestamp = curr.timestamp
				curr.save()
			}
		}
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


		//
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

	/*	/**
	 * This method returns a string location based on the
	 * name of the computer. It matches the computer name with the
	 * location map and returns a string accordingly.
	 * @param tempComputerName
	 * @return
	 *
	 def getLocation(def tempComputerName){
	 println "for computer name ${tempComputerName}"
	 /**
	 * This is the locationMap that contains the regex for
	 * finding the location of a workstation. SInce this is an initial
	 * commit, this map is created manually. Preferred method is to read
	 * this off a configuration file (csv,txt etc) and should be done in the
	 * later releases.
	 *
	 *
	 def locationMap = getLocationMappingFromCSV();
	 //		def locationMap= ['^LIBWKMCK[PM]1F[0-9]+[a-zA-Z]$':'McKeldin Library 1st floor',
	 //		 '^LIBWKMCK[PM]2F[0-9]+[a-zA-Z]$':'McKeldin Library 2nd floor',
	 //		 '^LIBWKMCK[PM]4F[0-9]+[a-zA-Z]$':'McKeldin Library 4th floor',
	 //		 '^LIBWKMCK[PM]5F[0-9]+[a-zA-Z]$':'McKeldin Library 5th floor',
	 //		 '^LIBWKMCK[PM]6F[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor',
	 //		 '^LIBWKMCK[PM]6F1[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6101',
	 //		 '^LIBWKMCK[PM]6F3[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6103',
	 //		 '^LIBWKMCK[PM]6F7[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6107',
	 //		 '^LIBWKMCK[PM]7F[0-9]+[a-zA-Z]$':'McKeldin Library 7th floor',
	 //		 '^LIBWKEPL[PM]1F[0-9]+[a-zA-Z]$':'Engineering Library 1st floor',
	 //		 '^LIBWKEPL[PM]2F[0-9]+[a-zA-Z]$':'Engineering Library 2nd floor',
	 //		 '^LIBWKEPL[PM]3F[0-9]+[a-zA-Z]$':'Engineering Library 3rd floor',
	 //		 '^LIBWKCHM[PM]1F[0-9]+[a-zA-Z]$':'Chemistry Library 1st floor',
	 //		 '^LIBWKCHM[PM]2F[0-9]+[a-zA-Z]$':'Chemistry Library 2nd floor',
	 //		 '^LIBWKCHM[PM]3F[0-9]+[a-zA-Z]$':'Chemistry Library 3rd floor',
	 //		 '^LIBWKNON[PM]1F[0-9]+[a-zA-Z]$':'Nonprint Library 1st floor',
	 //		 '^LIBWKMDR[PM]1F[0-9]+[a-zA-Z]$':'MARYLANDIA',
	 //		 '^LIBWKPAL[PM]1F[0-9]+[a-zA-Z]$':'PAL 1st floor',
	 //		 '^LIBWKPAL[PM]2F[0-9]+[a-zA-Z]$':'PAL 2nd floor',
	 //		 '^LIBWKART[PM]1F[0-9]+[a-zA-Z]$':'Art Library 1st floor',
	 //		 '^LIBWKARC[PM]1F[0-9]+[a-zA-Z]$':'Arch Library'
	 //		 ]
	 boolean regexCheck = false
	 def pattern=""
	 def retLocation=""
	 for (var in locationMap){
	 pattern = ~/${var.value}/
	 //println "Pattern to be checked is ${pattern}"
	 assert pattern instanceof Pattern
	 regexCheck = pattern.matcher(tempComputerName).matches();
	 println "Regex check = ${regexCheck}"
	 if(regexCheck){
	 retLocation = var.key
	 return retLocation
	 }
	 }
	 }
	 */

	/**
	 * This method gets the location mapping from the FILE_PATH.
	 * It returns a map of Location vs its regex pattern
	 * @return locationMap [key as location: value as regex pattern]
	 */
	def getLocationMappingFromCSV(){
		CSVReader reader = new CSVReader(new FileReader(FILE_PATH));
		String [] nextLine;
		int counter = 0
		def retLocationMap=[:]
		while ((nextLine = reader.readNext()) != null) {
			//INcrement the count by 1 for every new line.
			counter++

			if(counter==1){
				//Skip this iteration since this is the header
				continue
			}else{
				retLocationMap.put(nextLine[2].toString(),nextLine[1].toString())

			}

			// nextLine[] is an array of values from the line
			//System.out.println(nextLine[0] +" "+ nextLine[1] );
		}

		return retLocationMap
	}

	/**
	 * This function returns the symbol vs the location name map. 
	 * Eg. MCK1F=McKeldin Library 1st floor
	 * @return retSymMap
	 */
	def getSymVsLocationMap(){

		CSVReader reader = new CSVReader(new FileReader(FILE_PATH));
		String [] nextLine;
		int counter = 0
		def retSymMap=[:]
		while ((nextLine = reader.readNext()) != null) {
			//INcrement the count by 1 for every new line.
			counter++

			if(counter==1){
				//Skip this iteration since this is the header
				continue
			}else{
				retSymMap.put(nextLine[2].toString(),nextLine[0].toString())

			}

			// nextLine[] is an array of values from the line
			//System.out.println(nextLine[0] +" "+ nextLine[1] );
		}

		return retSymMap
	}

}
