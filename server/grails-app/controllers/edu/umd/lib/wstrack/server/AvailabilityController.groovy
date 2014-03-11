package edu.umd.lib.wstrack.server
import java.util.regex.Pattern
class AvailabilityController {

    def listAvailable() { 
		
		//Filter out non standard names
		def matchedAllCurrentList= []
		matchedAllCurrentList=getAllMatchedCurrentList();
		
		//Get total count of all the available systems
		// We can do this since the system only updates a system
		// status to either login/log off in the current list.
		//The following line would not work since matchedAllCurrentList doesnot have a domain class of its own.
		//def currentAvailableCount = matchedAllCurrentList.countByStatusILike("Logout");
		
		//Doing it the old fashioned way
		def currentAvailableCount = 0;
		for(Current tempCurrent:matchedAllCurrentList){
			if(tempCurrent.getStatus().equalsIgnoreCase("logout")){
				currentAvailableCount++;
			}
		}
		
		//This gives the total count of all the systems with standard name.
		def totalCount = matchedAllCurrentList.size();
		
		
		//Filter out all available system available.
		def currentAvailableList = []
		currentAvailableList = getAllAvailableSystems(matchedAllCurrentList)
		
		
//		for(Current current:currentAvailableList){
//			render "Matched list Pattern = ${current.computerName} <br>"
//		}
		
		return [currentAvailableList:currentAvailableList, currentAvailableCount:currentAvailableCount, totalCount:totalCount]
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
		def pattern = ~/LIBWK(MCK|NON|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7]F(1|3|7)?\d+[a-zA-Z]$/
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
}
