public  without sharing class TrainerController {
    @AuraEnabled(cacheable=true)
    public static List<Fitness_Trainer__c> getTrainerListHandler() {
           return [SELECT 
                    Name,Last_Name__c,Photo__c,Specialities__c,
                    Certifications__c, Availability_Schedule__c 
                    FROM  Fitness_Trainer__c where Working_Status__c = 'Active'
                    ];  
   
    }
}