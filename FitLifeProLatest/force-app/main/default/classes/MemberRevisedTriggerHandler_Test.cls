@isTest()
public class MemberRevisedTriggerHandler_Test {
    
	@isTest()
    public static void testDoAction(){
        
        List<Fitness_Trainer__c> trainer = new List<Fitness_Trainer__c>();
        trainer.add(new Fitness_Trainer__c(Name = 'Aradhya', Last_Name__c = 'Reddy', Phone_Number__c = '9658741235', 
                                                             Email__c = 'aradhya@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 50000));
        
        trainer.add(new Fitness_Trainer__c(Name = 'Abhi', Last_Name__c = 'naya', Phone_Number__c = '7778741235', 
                                                             Email__c = 'abhi@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Afternoon Slot - 12pm to 4pm', Salary__c = 60000));
        
        trainer.add(new Fitness_Trainer__c(Name = 'Pranav', Last_Name__c = 'Kumar', Phone_Number__c = '8859765235', 
                                                             Email__c = 'pranav@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Morning Slot - 6am to 12pm', Salary__c = 55000)); 
        
        trainer.add(new Fitness_Trainer__c(Name = 'Amrutha', Last_Name__c = 'Kumari', Phone_Number__c = '9585858585', 
                                                             Email__c = 'amrutha@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 70000));        
        insert trainer;
        Member__c member = new Member__c(First_Name__c = 'Anurag ', Last_Name__c = 'Kumar ', Phone__c = '9685742547', 
            						Email__c = 'Anurag'  + '@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', Status__c = 'Active',
                              		DOB__c = date.valueOf('1981-10-15'), Time_Slot__c = 'Evening Slot - 4pm to 10pm' );
                   
        Test.startTest();           
		insert member; 
        Member__c memberRecord1 = [SELECT Id, First_Name__c,Fitness_Trainer__c FROM Member__c WHERE First_Name__c = 'Anurag'];
        Fitness_Trainer__c trainerRecord1 = [SELECT Id, Name, Assigned_Members__c FROM Fitness_Trainer__c WHERE id =: memberRecord1.Fitness_Trainer__c ];
        Fitness_Trainer__c trainerRecord2 = [SELECT Id, Name, Assigned_Members__c FROM Fitness_Trainer__c WHERE Name = 'Amrutha'];
        //system.debug('memberRecord1 Test : '+ memberRecord1);
        //system.debug('trainerRecord1 Test : '+ trainerRecord1);
        member.Fitness_Trainer__c = trainerRecord2.Id; 
        member.Id = memberRecord1.Id;
        //system.debug('member Test : '+ member);
        update member;        
        delete member;
        undelete member;
        /*member.Fitness_Trainer__c = null; 
        update member;*/        
        test.stopTest();
        
        MemberRevisedTriggerHandler memberHandler = new MemberRevisedTriggerHandler();
    	memberHandler.doAction();
        
        Fitness_Trainer__c trainerRecord = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Name = 'Amrutha'];
        System.assertEquals(1, trainerRecord.Assigned_Members__c, 'Assigned Member count should match');        
    }  

}