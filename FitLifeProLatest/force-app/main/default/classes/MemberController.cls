public with sharing class MemberController {

    @AuraEnabled(cacheable=true)
    public static List<Fitness_Trainer__c> getRelatedMembers(String recordId) {
        return [SELECT Id, Name, Assigned_Members__c , 
        (SELECT Id, Fitness_Trainer__c FROM Members__r) 
        FROM Fitness_Trainer__c 
        WHERE Id = : recordId];
    }
}