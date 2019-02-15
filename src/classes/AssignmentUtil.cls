/**
 * Assignment Utility class for rerunning the assignments. Can be used for Leads and Cases.
 */
public with sharing class AssignmentUtil {
	
	// Filter the records based on Metadata Types.
	public static List<Id> filterIds(List<Sobject> records, String objectName) {
		List<Id> rerunIds = new List<Id>();
		String soql = 'Select Id, whereClause__c from Assignment_Config__mdt where Object_Name__c = \'' + String.escapeSingleQuotes(objectName) + '\'';
		
		List<Assignment_Config__mdt> assignmentRules = Database.query(soql);
		
		if (assignmentRules != null && assignmentRules.size() > 0) {
			try {
				String soqlTemplate = 'Select Id from {0} where {1} and Id in :records';
				List<Object> params = new List<Object>{objectName, assignmentRules[0].whereClause__c};
				String recordSOQL = String.format(soqlTemplate, params);	
				for (SObject rec: Database.query(recordSOQL)) {
					rerunIds.add(rec.Id);
				}
			} catch (Exception ex) {
				// Do nothing
				throw new AssignmentUtilException('Error when querying the records, check for Metadata type where clause' + ex.getMessage());
			}
		}

		return rerunIds;
	}

	// rerun the assignment logic
	public static void rerun(List<Id> recordIds, String objectName) {
		// Set the assignemnt DML header to true
		Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true; 
        
        // Query
        String soqlQuery = 'Select Id from ' + objectName + ' where Id in :recordIds';

        try {
        	List<SObject> records = Database.query(soqlQuery);
	        for (SObject rec : records)
	        	rec.setOptions(dmo);

	        update records;  	
        } catch (Exception ex) {
        	system.debug('Something went wrong ' + ex.getMessage());
        }
        
	}

	public class AssignmentUtilException extends Exception {}


}