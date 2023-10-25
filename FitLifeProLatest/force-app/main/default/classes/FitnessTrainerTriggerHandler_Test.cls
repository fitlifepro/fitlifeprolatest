@isTest()
public class FitnessTrainerTriggerHandler_Test {
    
	@isTest()
    public static void testDoAction(){
        
        List<Fitness_Trainer__c> trainer = new List<Fitness_Trainer__c>();
        trainer.add(new Fitness_Trainer__c(Name = 'Rajan', Last_Name__c = 'Reddy', Phone_Number__c = '9658741235', Assigned_Members__c = 2,
                                                             Email__c = 'rajan@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 50000));
        
        trainer.add(new Fitness_Trainer__c(Name = 'Praneel', Last_Name__c = 'Kumar', Phone_Number__c = '7778741235', 
                                                             Email__c = 'praneel@gmail.com', Working_Status__c = 'Active', Assigned_Members__c = 3,
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 60000)); 
        
        trainer.add(new Fitness_Trainer__c(Name = 'Preksha', Last_Name__c = 'Kumari', Phone_Number__c = '9585858585', 
                                                             Email__c = 'preksha@gmail.com', Working_Status__c = 'In-Active', Assigned_Members__c = 2,
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 70000));        
        insert trainer;
        Fitness_Trainer__c trainerRecord2 = [SELECT Id, Name, Assigned_Members__c, Working_Status__c FROM Fitness_Trainer__c WHERE Name = 'Praneel'];
        //List<Member__c> member = new List<Member__c>();
        Member__c member = new Member__c(First_Name__c = 'Ratan', Last_Name__c = 'Kumar ', Phone__c = '9685742547', 
            						Email__c = 'ratan'  + '@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', Fitness_Trainer__c = trainerRecord2.Id,
                              		DOB__c = date.valueOf('1981-10-15'), Time_Slot__c = 'Evening Slot - 4pm to 10pm', Status__c = 'Active');
                   
        //member.add(new Member__c(First_Name__c = 'Anoop ', Last_Name__c = 'Kulkarni ', Phone__c = '9632587456', 
        //    					Email__c = 'anoop@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', 
        //                        DOB__c = date.valueOf('1979-10-20'))); 
        Test.startTest();        
		insert member; 
     
        Member__c memberRecord1 = [SELECT Id, First_Name__c,Fitness_Trainer__c FROM Member__c WHERE First_Name__c = 'Ratan'];
        //system.debug('memberRecord1 :' + memberRecord1);
        Fitness_Trainer__c newTrainer = New Fitness_Trainer__c();
        Fitness_Trainer__c trainerRecord1 = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Name = 'Preksha'];
        newTrainer.Id = memberRecord1.Fitness_Trainer__c;
        newTrainer.Working_Status__c = 'In-Active'; 
        //system.debug('newTrainer :' + newTrainer);
        //system.debug('trainerRecord2 :' + trainerRecord2);
        update newTrainer;        
        test.stopTest();
        
        FitnessTrainerTriggerHandler trainerHandler = new FitnessTrainerTriggerHandler();
    	trainerHandler.doAction();
        
        Fitness_Trainer__c trainerRecord = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Id =: memberRecord1.Fitness_Trainer__c];
        system.debug('Assigned_Members__c: '+ trainerRecord.Assigned_Members__c);
        System.assertEquals(0, trainerRecord.Assigned_Members__c, 'Assigned Member count should match');        
    }  

}