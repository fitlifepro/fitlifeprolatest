@isTest
public class TrainerDetailsTestClass {
@isTest
Public static void testGetTrainerListHandler() {
        
        List<Fitness_Trainer__c> trainers = new List<Fitness_Trainer__c>();
        for (Integer i = 0; i < 5; i++) {
            trainers.add(new Fitness_Trainer__c(
                Name = 'Trainer ' + i,
                Email__c = 'trainer' + i + '@gmail.com',
                Last_Name__c = 'Lastname ' + i,
                Phone_Number__c = '123456789' + i
             ));
        }
        insert trainers;
       List<Fitness_Trainer__c> result = TrainerController.getTrainerListHandler();
       System.assertEquals(5, result.size());
     }
}