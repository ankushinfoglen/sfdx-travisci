trigger AccountTrigger on Account (after insert, after update, 
                                        after delete, after undelete) {
    

      // modified objects whose parent records should be updated
        Account[] objects = null;   
        
     if (Trigger.IsUpdate) {
         objects = Trigger.old;
     } else {
        /*
            Handle any filtering required, specially on Trigger.isUpdate event. If the rolled up fields
            are not changed, then please make sure you skip the rollup operation.
            We are not adding that for sake of similicity of this illustration.
        */ 
        objects = Trigger.new;
     }

     /*
      First step is to create a context for LREngine, by specifying parent and child objects and
      lookup relationship field name
     */
     LREngine.Context ctx = new LREngine.Context(Account.SobjectType, // parent object
                                            Contact.SobjectType,  // child object
                                            Schema.SObjectType.Contact.fields.AccountId // relationship field name
                                            );     
     /*
      Next, one can add multiple rollup fields on the above relationship. 
      Here specify 
       1. The field to aggregate in child object
       2. The field to which aggregated value will be saved in master/parent object
       3. The aggregate operation to be done i.e. SUM, AVG, COUNT, MIN/MAX
     */
     ctx.add(
            new LREngine.RollupSummaryField(
                                            Schema.SObjectType.Account.fields.Ankuli__Total_Contact__c,
                                            Schema.SObjectType.Contact.fields.Id,
                                            LREngine.RollupOperation.Count 
                                         )); 
                                         

     /* 
      Calling rollup method returns in memory master objects with aggregated values in them. 
      Please note these master records are not persisted back, so that client gets a chance 
      to post process them after rollup
      */ 
     Sobject[] masters = LREngine.rollUp(ctx, objects);    

     // Persiste the changes in master
     update masters;
}