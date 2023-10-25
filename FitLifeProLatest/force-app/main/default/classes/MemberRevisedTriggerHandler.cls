public class MemberRevisedTriggerHandler {
    
    //Trigger Name : MemberRevisedTrigger
    List<Member__c> triggerNew;
    List<Member__c> triggerOld;
    Map<Id,Member__c> triggerNewMap;
    Map<Id,Member__c> triggerOldMap;    
    
    public MemberRevisedTriggerHandler(){
        
        triggerNew = (List<Member__c>)Trigger.New; // type cast from SObject to Member__c
        triggerOld = (List<Member__c>)Trigger.Old;
        triggerNewMap = (Map<Id,Member__c>)Trigger.NewMap;
        triggerOldMap = (Map<Id,Member__c>)Trigger.OldMap;
    }
    
    public void doAction(){        
        
        SWITCH on Trigger.operationType{
            
            WHEN BEFORE_INSERT{
                assignTrainerToMember();  
            }
            WHEN AFTER_INSERT{
                assignedMemberCount(triggerNew);
            }            
            WHEN AFTER_UPDATE{
                assignedMemberCount(triggerNew);
            }   
            WHEN AFTER_DELETE{
                assignedMemberCount(triggerOld);
            }            
            WHEN AFTER_UNDELETE{
                assignedMemberCount(triggerNew);
            }             
        }
    }
    
    public void assignTrainerToMember(){        
        integer i = 0;
        system.debug('Inside assignTrainerToMember');
        List<Fitness_Trainer__c> trainerLst = [SELECT Id, Name, Assigned_Members__c 
                                               FROM Fitness_Trainer__c 
                                               WHERE Working_Status__c = 'Active' 
                                               AND Availability_Schedule__c =: triggerNew[0].Time_Slot__c
                                               ORDER BY Assigned_Members__c 
                                              ];
        
        for(Member__c member : triggerNew)
        {
            member.Fitness_Trainer__c = trainerLst[0].Id;            
        }  
    }
    
    
    public void assignedMemberCount(List<Member__c> memberLst)
    { 
        system.debug('Inside assignedMemberCount');
        set<Id> trainerIds = new set<Id>();
        for(Member__c member : memberLst){
           if(member.Fitness_Trainer__c != null){
                if(Trigger.isUpdate){                    
                    if(triggerOldMap.get(member.Id).Fitness_Trainer__c != member.Fitness_Trainer__c){
                            trainerIds.add(member.Fitness_Trainer__c);
                            trainerIds.add(triggerOldMap.get(member.Id).Fitness_Trainer__c);
                        }                    
                }else{
                    trainerIds.add(member.Fitness_Trainer__c);
                } 
           }else if(member.Fitness_Trainer__c == null && triggerOldMap.get(member.Id).Fitness_Trainer__c != null){
               trainerIds.add(triggerOldMap.get(member.Id).Fitness_Trainer__c);
           }
        }          
    
        if(trainerIds.size()>0){
            //system.debug('Trainer Ids : ' + trainerIds);
            //List<AggregateResult> memAggLst = [select count(id) memCount , Fitness_Trainer__c from member__c where Id in : trainerIds Group by Fitness_Trainer__c];
            List<Fitness_Trainer__c> trainerLst = [SELECT Id, Assigned_Members__c , 
                                                   (SELECT Id, Fitness_Trainer__c FROM Members__r) 
                                                   FROM Fitness_Trainer__c 
                                                   WHERE Id in : trainerIds 
                                                  ]; 
            List<Fitness_Trainer__c> newTrainerData = new List<Fitness_Trainer__c>();
            for(Fitness_Trainer__c trainerRecord : trainerLst){
                Fitness_Trainer__c trainer = new Fitness_Trainer__c();
                trainer.Assigned_Members__c = trainerRecord.Members__r.size();
                trainer.Id = (Id)trainerRecord.get('Id');
                newTrainerData.add(trainer);
            }
            if(!newTrainerData.isEmpty())
                database.update(newTrainerData);
          }
	}
}