trigger OppCount on Opportunity (after insert, after update, after delete, after undelete){
	
	if(trigger.isAfter)
	{
        Set<Id> setAccId = new Set<Id>();
        for(Opportunity objOpp : trigger.new)
        {
            if(objOpp.AccountId != null)
            setAccId.add(objOpp.AccountId);
        }
		List<Account> lstAccount = new List<Account>();
		for(AggregateResult objAggR : [Select Count(Id), AccountId from Opportunity 
                                       	where StageName='Closed Won' AND AccountId IN:setAccId  Group By AccountId])
		{
			lstAccount.add(new Account(Ankuli__Total_Opportunities_c__c=Integer.valueOf(objAggr.get('expr0')), Id= String.valueOf(objAggr.get('AccountId')) )); 
		}
		update lstAccount;
		
	}

}