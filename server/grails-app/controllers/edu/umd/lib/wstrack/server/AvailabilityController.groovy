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


		/******To be put in method that gives
		 * locationVSLIst of computers in that location*******/
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
		
		/*****************************************************/
		
		
		def locationVsCountsMap = new HashMap<String,Map<String,Integer>>() //of the form [Mck 1st floor:{Pc=3,Mac=4}]
		int macCount=0
		int pcCount=0
		String finder=""
		def countsMap=[]
		for(map in locationVsCurrentMap){
			//Reinitialize for the next iteration.
			macCount=0
			pcCount=0
			countsMap = new HashMap<String, Integer>()
			//iterate over each of the computer and find out the count for pcs and macs
			for(Current tempCurr:map.value){
				finder=findComputerOS(tempCurr.getComputerName())
				println "finder is ${finder}"
				if(finder.equalsIgnoreCase("PC")){
					pcCount++
				}else if(finder.equalsIgnoreCase("MAC")){
					macCount++
				}
				
			}
			//Populate the map with the counts
			countsMap.put("pc",pcCount)
			countsMap.put("mac",macCount)
			locationVsCountsMap.put(map.key, countsMap)
		}
		
		/****************************************************/

		def result = [locationVsCurrentMap:locationVsCurrentMap,locationVsCountsMap:locationVsCountsMap]

		//render result as JSON
		return result
		//return [locationVsCurrentMap:locationVsCurrentMap,locationVsCountsMap:locationVsCountsMap]
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
	 * and then returns the COMPLETE LIST WITH ONLY standard computer names. 
	 * @return
	 */
	List getAllMatchedCurrentList(){

		//This fetches the list with status logout. So basically this
		//fetches the list of available systems. def currentList = Current.list(fetch: [status:"logout"]);

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
	def getLocationByComputerName(def tempComputerName){

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
				retLocationMap.put(nextLine[1].toString(),nextLine[0].toString())

			}

			// nextLine[] is an array of values from the line
			//System.out.println(nextLine[0] +" "+ nextLine[1] );
		}

		return retLocationMap
	}
}
