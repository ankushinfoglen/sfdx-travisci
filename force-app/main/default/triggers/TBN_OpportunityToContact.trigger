trigger TBN_OpportunityToContact on Opportunity (after update, before update, after insert, after delete) 
{
    
    TBN_Opportunity_To_Contact objOpportuntiy = new TBN_Opportunity_To_Contact();
    Boolean isTrue = true;
    
     
    if(Trigger.isAfter && Trigger.isInsert)
    {
        objOpportuntiy.afterInsert(Trigger.newMap, isTrue);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        objOpportuntiy.afterUpdate(Trigger.newMap, isTrue);
    }
    
/*  if(Trigger.isBefore && Trigger.isUpdate)
    { 
        objOpportunity.beforeUpdate(Trigger.oldMap);
    }
    */
    
    if(Trigger.isAfter && Trigger.isDelete)
    {
        isTrue = false;
        objOpportuntiy.afterDelete(Trigger.oldMap, isTrue);
    }
}