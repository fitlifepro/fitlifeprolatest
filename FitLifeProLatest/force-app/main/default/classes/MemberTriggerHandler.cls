public class MemberTriggerHandler {
//Declaring the Context variable as Class level Variables
    List<Member__c> triggerNew;
    List<Member__c> triggerOld;
    Map<Id, Member__c> triggerNewMap;
    Map<Id, Member__c> triggerOldMap;
    
    //By creating constructor method, intializing Class level Variables as trigger context variables with type casting
    public MemberTriggerHandler()
    {
        triggerNew=(List<Member__c>)trigger.New;
        triggerOld=(List<Member__c>)trigger.Old;
        triggerNewMap=(Map<Id, Member__c>)trigger.NewMap;
        triggerOldMap=(Map<Id, Member__c>)trigger.OldMap;
    }
    
    //Entry Method
    Public void doAction()
    {
        Switch on Trigger.OperationType
        {
            when AFTER_INSERT
            {
                updateCountofMembers();
            }
            when AFTER_UPDATE
            {
                updateCountofMembers();
            }
            
        }
    }
    
    Public void updateCountofMembers()
    {
        //List<Trainer__c> trainersList=[select id, Count_of_Members__c (select id, Trainer__c from Accounts) from Trainer__c  ];
        List<Trainer__c> trainersList=[select id, Count_of_Members__c  
                                       from Trainer__c  ];
        List<Trainer__c> countToUpdate=new List<Trainer__c>();
        
        /*if(trigger.IsUpdate)
        {
            for(Account memRec:triggerNew)
            {
                if(triggerOldMap.get(memRec.Id).Trainer__c!=memRec.	Trainer__c)
                {
                    for(Trainer__c trainerRec:trainersList)
                    {
                        trainerRec.Count_of_Members__c = trainerRec.Accounts.size();
                        countToUpdate.add(trainerRec);
                    }
                }
            }
                if(countToupdate.size()>0)
                {
                    update countToUpdate;
                }
            
        }else 
        {*/
            for(Trainer__c trainerRec:trainersList)
            {
                trainerRec.Count_of_Members__c=trainerRec.Members__r.size();
                countToUpdate.add(trainerRec);
            }
            if(countToupdate.size()>0)
            {
                update countToUpdate;
            }
        //}
    }

}