trigger AccountUpdate on Account (after update)
{
    if(trigger.isAfter && Trigger.isUpdate)
    {
        Map<Id, Account> mapOldAccount = Trigger.oldMap;
        Map<Id, Account> mapNewAccount = Trigger.newMap;
        List<Id> lstAccountIds = new List<Id>();
        for(Account objAcc :  Trigger.new)
        {
            if(mapOldAccount.get(objAcc.Id).Phone != objAcc.Phone)
            {
                lstAccountIds.add(objAcc.Id);
            }
                
        }
        
        List<Contact> lstContactToUpdate = new List<Contact>();
        Set<Id> setContactIdtoUpdate = new Set<Id>();
        for(Case objCase : [Select  ContactId,AccountId from Case where AccountId IN: lstAccountIds])
        {
            If(!setContactIdtoUpdate.contains(objCase.ContactId))
            {
                lstContactToUpdate.add(new Contact(Id = objCase.ContactId, Phone= mapNewAccount.get(objCase.AccountId).Phone));
                setContactIdtoUpdate.add(objCase.ContactId);
            }
            
        }
        update lstContactToUpdate ;
    }
}