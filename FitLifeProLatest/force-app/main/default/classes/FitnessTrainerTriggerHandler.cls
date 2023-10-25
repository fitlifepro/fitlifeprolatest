public class FitnessTrainerTriggerHandler {
    
    //Trigger Name : FitnessTrainerTrigger
    List<Fitness_Trainer__c> triggerNew;
    List<Fitness_Trainer__c> triggerOld;
    Map<Id,Fitness_Trainer__c> triggerNewMap;
    Map<Id,Fitness_Trainer__c> triggerOldMap;
    
    public FitnessTrainerTriggerHandler(){
        
        triggerNew = (List<Fitness_Trainer__c>)Trigger.New; // type cast from SObject to Member__c
        triggerOld = (List<Fitness_Trainer__c>)Trigger.Old;
        triggerNewMap = (Map<Id,Fitness_Trainer__c>)Trigger.NewMap;
        triggerOldMap = (Map<Id,Fitness_Trainer__c>)Trigger.OldMap;
    }
    
    public void doAction(){         
        
        SWITCH on Trigger.operationType{
            
            WHEN AFTER_INSERT{
                inActiveTrainer();  
            }
            WHEN AFTER_UPDATE{                
                inActiveTrainer(); 
            }                        
        }
    }
    
    public void inActiveTrainer(){        
        system.debug('Inside inActiveTrainer ');
        set<String> inActiveTrainer = new set<String>();
        List<Member__c> memberListUpdate = new List<Member__c>();
        for(Fitness_Trainer__c trainer : triggerNew){
            if(trainer.Working_Status__c == 'In-active' && trainer.Assigned_Members__c > 0){                
                inActiveTrainer.add(trainer.Id);				                
            }
        }
        if(!inActiveTrainer.isEmpty()){
            List<Fitness_Trainer__c> trainerList = [SELECT Id, Name, Assigned_Members__c 
                                                   FROM Fitness_Trainer__c
                                                   WHERE Working_Status__c = 'Active'
                                                   ORDER BY Assigned_Members__c
                                                   ];            
            List<Member__c> memberList = [SELECT Id, Fitness_Trainer__c
                                          FROM Member__c
                                          WHERE Fitness_Trainer__c in : inActiveTrainer                                               
                                         ];
            if(memberList.size() > 0){
                integer trainerListSize = trainerList.size();
                integer i = 0;
                system.debug('Member List Size : ' + memberList.size() + '   Trainer List Size : ' + trainerListSize);        
                for(Member__c memberRecord : memberList){            
                    Id tempTrainer = trainerList[Math.Mod (i++, trainerListSize)].Id;                    
                    Member__c member = new Member__c();
                    member.Fitness_Trainer__c = tempTrainer;
                    member.Id = memberRecord.Id;
                    memberListUpdate.add(member); 
                    //system.debug('Member List for Update : ' + memberListUpdate);
                }            
            }
               
            if(!memberListUpdate.isEmpty()){
                   database.update(memberListUpdate);
            }
        }
    }
}