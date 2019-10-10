trigger UserTrigger on User (after insert, after update) {
    
    UserTriggerHandler  objHandler = new UserTriggerHandler();
    if(Trigger.isAfter && (Trigger.IsInsert || Trigger.isUpdate) )
    {
        objHandler.afterInsertUpdate(Trigger.New);
    }
    

}