@isTest
public class FitnessClassesControllerTest {
    
    @isTest
    static void testListOfClasses() {
        // Create test data
        Date testDate = Date.newInstance(2023, 10, 23);
        time testtime =Time.newInstance(System.now().hour(), System.now().minute(), System.now().second(), 0);
        
        Fitness_Class__c testFitnessClass = new Fitness_Class__c(Date__c = testDate, Time__c = testtime, Activity__c = 'Yoga', Duration__c = '60', Available_Slots__c = 10, Booking__c = 'Book');
        insert testFitnessClass;
        Fitness_Class__c testFitnessClass1 = new Fitness_Class__c(Date__c = testDate, Time__c = testtime, Activity__c = 'Pilates', Duration__c = '60', Available_Slots__c =0, Booking__c = 'Book');
        insert testFitnessClass1;
        // Call the method to be tested
        String serializedRecords = FitnessClassesController.ListOfClasses(testDate);

        // Add assertions based on the expected behavior
        System.assertNotEquals(serializedRecords, null);
        // Add more assertions as per the expected behavior
    }

    @isTest
    static void testUpdateAvailableSlots() {
        // Create test data
        Fitness_Class__c testFitnessClass = new Fitness_Class__c(Activity__c = 'Yoga', Available_Slots__c = 5);
        insert testFitnessClass;
        
         Fitness_Class__c testFitnessClass1 = new Fitness_Class__c(Activity__c = 'Pilates', Available_Slots__c = 5);
        insert testFitnessClass1;

        // Call the method to be tested
        String result = FitnessClassesController.updateAvaliableSlots('Yoga');
        string result1 = FitnessClassesController.updateAvaliableSlots('Pilates');

        // Retrieve the updated record
        Fitness_Class__c updatedFitnessClass = [SELECT Available_Slots__c FROM Fitness_Class__c WHERE Id = :testFitnessClass.Id];

        // Add assertions based on the expected behavior
        System.assertEquals(result, 'Success');
        System.assertEquals(updatedFitnessClass.Available_Slots__c, 4);
        System.assertEquals(result1, 'Success');
        System.assertEquals(updatedFitnessClass.Available_Slots__c, 0);
        // Add more assertions as per the expected behavior
    }

}