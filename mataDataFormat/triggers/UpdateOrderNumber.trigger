// TO check workflow trigger validation execution order

trigger UpdateOrderNumber on Opportunity (before insert, after insert, before update, after update){
Static Boolean isRepeat = false;

    If(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity objOpp :  Trigger.New){
           objOpp.OrderNumber__c = 'testy';
        }
    }
    
    If(!isRepeat && Trigger.isAfter && Trigger.isUpdate){
        List<Opportunity> lstOpp = new List<Opportunity>();
       for(Opportunity objOpp :  [select id from opportunity where Id IN :Trigger.New]){
          
          objOpp.OrderNumber__c = 'test1';
          lstOpp.add(objOpp);
        } 
        isRepeat = true;
        //update lstOpp;
    }
    
}