/**
 * Test class that covers LeadAssignmentTrigger, AssignmentUtil and QueueableAssignments Apex classes.
 */
@isTest
private class AssignmentUtilTest {
	
	// Load some sample Lead data. If required fields make changes to include required fields.
	@testSetup
	static void loadTestData() {
		
		List<Assignment_Config__mdt> assignmentRules = [Select Id, Object_Name__c, whereClause__c from Assignment_Config__mdt where Object_Name__c = 'Lead'];
		// Check if Lead Assignment Config is defined. otherwise fail.
		system.assertNotEquals(null,assignmentRules);
		// Insert leads
		List<Lead> testLeads = new List<Lead>();
		testLeads.add(new Lead(FirstName='FirstName',LastName='LastName',LeadSource='Web',Company='TestCompany1'));
		testLeads.add(new Lead(FirstName='FirstName2',LastName='LastName2',LeadSource='Web',Company='TestCompany2'));
		testLeads.add(new Lead(FirstName='FirstName3',LastName='LastName3',LeadSource='Email',Company='TestCompany3'));
		testLeads.add(new Lead(FirstName='FirstName4',LastName='LastName4',LeadSource='TradeShow',Company='TestCompany4'));
		insert testLeads;

	}

	// Test the individual Apex class Assignment Util
	@isTest static void testAssignmentUtil() {
		
		List<Lead> leads = [Select Id from Lead];
		
		system.assertEquals(4,leads.size());
		
		Test.startTest();
			List<Id> leadIds = AssignmentUtil.filterIds(leads,'Lead');
			System.assertEquals(2,leadIds.size());
		Test.stopTest();
			
	}
	
	// Test LeadAssignmentTrigger and also the QueueableAssignments class.
	@isTest static void testLeadAssignmentTrigger() {

		// Implement test code
		Test.startTest();
			Lead ld = new Lead(FirstName='Dummy',LastName='Last',LeadSource='Web',Company='None');
			insert ld;
		Test.stopTest();
		
		List<Lead> leads = [Select Id from Lead where FirstName = 'Dummy'];
		system.assertEquals(1,leads.size());
			
	}
	
}