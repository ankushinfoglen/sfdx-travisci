({
	
	 recordUpdated : function(component, event, helper) {
		 helper.recordUpdated(component, event, helper);
	},
    
    
    doInit : function(component, event, helper) {
        console.log("In it called");
         var eventParams = event.getParams();

        if(eventParams.changeType === "LOADED") {

        var acc = component.get("v.accountRecord");
        console.log(acc.Name);
        console.log($A.get("$SObjectType.CurrentUser.Id"));
        acc.AccountNumber = 'asdasd';
        component.find("accRec").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                /*
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "type":'success',
                    "message": "The record was saved."
                });
               resultsToast.fire();
                */
                $A.get("e.force:closeQuickAction").fire();
            } else if (saveResult.state === "INCOMPLETE") {
                
            } else if (saveResult.state === "ERROR") { 
                var errMsg = "";
                for (var i = 0; i < saveResult.error.length; i++) {
                    errMsg += saveResult.error[i].message + "\n";
                }
               // component.set("v.recordSaveError", errMsg);
                
            } else {
               // component.set("v.recordSaveError",'Unknown problem, state: ' + saveResult.state + ', error: ' + 
                              //JSON.stringify(saveResult.error));
            }
        }));}
	}
    
})