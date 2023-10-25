public class RegistrationController {
        @AuraEnabled
   public static string createRegistration(string firstName,string lastName,string email,string phone)
   {
    Registration__c reg=new Registration__c();
    reg.First_Name__c=firstName;
    reg.Last_Name__c=lastName;
    reg.Email__c=email;
    reg.Phone__c=phone;
    insert reg;
    return reg.Id;
   }

    }