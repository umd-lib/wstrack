package edu.umd.lib.wstrack.server
import java.util.regex.Pattern
class AvailabilityController {
	
	

    def listAvailable() { 
		
		//Filter out non standard names
		def matchedAllCurrentList= []
		matchedAllCurrentList=getAllMatchedCurrentList();
		
		//Set Locations for the system.
		setLocations(matchedAllCurrentList)
		
		//This gives the total count of all the systems with standard name.
		def totalCount = matchedAllCurrentList.size();
		
		//Filter out all available system available and their count
		def currentAvailableList = []
		def currentAvailableCount = 0;
		currentAvailableList = getAllAvailableSystems(matchedAllCurrentList)
		currentAvailableCount = currentAvailableList.size()
		
		return [currentAvailableList:currentAvailableList, currentAvailableCount:currentAvailableCount, totalCount:totalCount, matchedAllCurrentList:matchedAllCurrentList]
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
		def pattern = ~/^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7]F(1|3|7)?\d+[a-zA-Z]$/
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
	
	/**
	 * This method returns a string location based on the
	 * name of the computer. It matches the computer name with the
	 * location map and returns a string accordingly.
	 * @param tempComputerName
	 * @return
	 */
	def getLocation(def tempComputerName){
		
		println "for computer name ${tempComputerName}"
		/**
		 * This is the locationMap that contains the regex for
		 * finding the location of a workstation. SInce this is an initial
		 * commit, this map is created manually. Preferred method is to read
		 * this off a configuration file (csv,txt etc) and should be done in the
		 * later releases.
		 *
		 */
		def locationMap = ['^LIBWKMCK[PM]1F[0-9]+[a-zA-Z]$':'McKeldin Library 1st floor',
			'^LIBWKMCK[PM]2F[0-9]+[a-zA-Z]$':'McKeldin Library 2nd floor',
			'^LIBWKMCK[PM]4F[0-9]+[a-zA-Z]$':'McKeldin Library 4th floor',
			'^LIBWKMCK[PM]5F[0-9]+[a-zA-Z]$':'McKeldin Library 5th floor',
			'^LIBWKMCK[PM]6F[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor',
			'^LIBWKMCK[PM]6F1[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6101',
			'^LIBWKMCK[PM]6F3[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6103',
			'^LIBWKMCK[PM]6F7[0-9]+[a-zA-Z]$':'McKeldin Library 6th floor RM 6107',
			'^LIBWKMCK[PM]7F[0-9]+[a-zA-Z]$':'McKeldin Library 7th floor',
			'^LIBWKEPL[PM]1F[0-9]+[a-zA-Z]$':'Engineering Library 1st floor',
			'^LIBWKEPL[PM]2F[0-9]+[a-zA-Z]$':'Engineering Library 2nd floor',
			'^LIBWKEPL[PM]3F[0-9]+[a-zA-Z]$':'Engineering Library 3rd floor',
			'^LIBWKCHM[PM]1F[0-9]+[a-zA-Z]$':'Chemistry Library 1st floor',
			'^LIBWKCHM[PM]2F[0-9]+[a-zA-Z]$':'Chemistry Library 2nd floor',
			'^LIBWKCHM[PM]3F[0-9]+[a-zA-Z]$':'Chemistry Library 3rd floor',
			'^LIBWKNON[PM]1F[0-9]+[a-zA-Z]$':'Nonprint Library 1st floor',
			'^LIBWKMDR[PM]1F[0-9]+[a-zA-Z]$':'MARYLANDIA',
			'^LIBWKPAL[PM]1F[0-9]+[a-zA-Z]$':'PAL 1st floor',
			'^LIBWKPAL[PM]2F[0-9]+[a-zA-Z]$':'PAL 2nd floor',
			'^LIBWKART[PM]1F[0-9]+[a-zA-Z]$':'Art Library 1st floor',
			'^LIBWKARC[PM]1F[0-9]+[a-zA-Z]$':'Arch Library'
			]
		
		boolean regexCheck = false
		/**
		 * Confirming again that this is a valid name. 
		 * Also, this makes it easier to initialize the pattern 
		 * variable.
		 */
		def pattern = ~/^LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7]F(1|3|7)?\d+[a-zA-Z]$/
		
		def retLocation=""

		for (var in locationMap){

			pattern = ~/${var.key}/
			//println "Pattern to be checked is ${pattern}"
			assert pattern instanceof Pattern
			regexCheck = pattern.matcher(tempComputerName).matches();
			println "Regex check = ${regexCheck}"
			if(regexCheck){
				retLocation = var.value
				return retLocation
			}
		}
		
	}
}
