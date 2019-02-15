/**
 * Use the logic within any trigger or execute the trigger with the logic. You can use the same logic with Case object 
 * as well. Change the object Name to Case instead of Lead.
 */
trigger LeadAssignmentTrigger on Lead (after insert) {

    // Run this logic only for after insert events.
    if (trigger.isInsert && trigger.isAfter) {
        // Get the configs for Lead object - based on trigger objec
        List<Id> rerunIds = AssignmentUtil.filterIds(trigger.new,'Lead');
        QueueableAssignments queueJob = new QueueableAssignments(rerunIds,'Lead');
        ID jobID = System.enqueueJob(queueJob);
    }
}