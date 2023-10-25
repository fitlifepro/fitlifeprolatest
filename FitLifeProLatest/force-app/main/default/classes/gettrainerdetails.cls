public with sharing class gettrainerdetails {
    @AuraEnabled(cacheable=true)
    public static List<Trainer__c> fetchTrainerRecords(){
        List<Trainer__c> trainerList = new List<Trainer__c>();
        try {
            trainerList = [SELECT Name, 
                             Email__c, Certifications__c, Phone_Number__c, Specialities__c, Availability_Schedule__c, Photo__c
                            FROM Trainer__c
                        ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return trainerList;
    }
}