public without sharing class FitnessClassesController {
    @AuraEnabled
    public  static String ListOfClasses(Date CDate){
      String userDate;
        userDate = String.valueOf(CDate).removeEnd(' 00:00:00');
        Date userDate1 = Date.valueOf(userDate);
        List<Fitness_Class__c> FitList = [Select Day__c,Time__c,Activity__c,Duration__c,
        Available_Slots__c,Booking__c from Fitness_Class__c where Date__c =: userDate1];
        List<map<String,Object>> FitnessMapList  = new List<Map<String, Object>>();
        for( Fitness_Class__c fRec: FitList ){
          Map<String, Object> FitrecordMap = new Map<String, Object>();
          FitrecordMap.put('Day__c', fRec.Day__c);
          // Convert the Time to a DateTime object and format it
      DateTime dateTimeValue = DateTime.newInstance(
      Date.newInstance(2000, 1, 1), 
      Time.newInstance(fRec.Time__c.hour(), fRec.Time__c.minute(), fRec.Time__c.second(), 0)
  );
     FitrecordMap.put('Time__c', dateTimeValue.format('h:mm a'));
       //   FitrecordMap.put('Time__c', fRec.Time__c.format('h:mm a'));
          FitrecordMap.put('Activity__c', fRec.Activity__c);
          FitrecordMap.put('Duration__c', fRec.Duration__c);
          FitrecordMap.put('Available_Slots__c', fRec.Available_Slots__c);
          if(fRec.Available_Slots__c == 0)
          {
            FitrecordMap.put('Booking__c','Full');
            
          }
          else{
            FitrecordMap.put('Booking__c', fRec.Booking__c);
          }
          
          FitnessMapList.add(FitrecordMap);
        }

        String serializedRecords = JSON.serialize(FitnessMapList);

        return serializedRecords;
    }
    @AuraEnabled
    public  static String updateAvaliableSlots(String Activity){
      Fitness_Class__c fObj = new Fitness_Class__c();
      Fitness_Class__c FitRec = [Select Id,Day__c,Time__c,Activity__c,Duration__c,
        Available_Slots__c,Booking__c from Fitness_Class__c where Activity__c =: Activity];
        if (FitRec != null) {
          fObj.id = FitRec.Id;
          fObj.Available_Slots__c = FitRec.Available_Slots__c - 1;
          system.debug(FitRec);
          system.debug(fObj);
          update fObj;
          return 'Success';
      } 
      else {
          return 'Fitness class record not found';
      }
        
    }

    
}