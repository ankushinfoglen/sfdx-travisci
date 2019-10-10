trigger LeadAssignment on Lead (before insert) {

    LeadAssignmentHandler objHandler = new LeadAssignmentHandler();
    if(trigger.isBefore && trigger.isInsert){
        objHandler.BeforeInsertLead(Trigger.new);
    } 

}