trigger TBN_Contact on Contact (after insert, after update, after delete, before delete) 
{
    
    
    TBN_ContactHandler objHandler = new TBN_ContactHandler();
    
    
    
    if(Trigger.isAfter && Trigger.isInsert)
    {
        objHandler.afterInsert(Trigger.newMap); 
    }
    
    else if(Trigger.isAfter && Trigger.isUpdate)
    {
        objHandler.afterUpdate(Trigger.newMap);
    }
    else if(Trigger.isAfter && Trigger.isDelete)
    {
        objHandler.afterDelete(Trigger.oldMap);
    }
    
}