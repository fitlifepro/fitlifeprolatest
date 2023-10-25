public class PDFGenerateCtrl {
    public Member__c con{get;set;}
    public String currentRecordId{get;set;}
 
    public PDFGenerateCtrl(){
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        if(currentRecordId != null && String.isNotBlank(currentRecordId)){
            con = [SELECT Id, First_Name__c, Email__c,Area__c,Membership_Plan__c,Membership_Start_Date__c,Membership_End_Date__c,Time_Slot__c FROM Member__c WHERE Id =:currentRecordId];
        }
    }
 
    @AuraEnabled(cacheable=true)
    public static List<Member__c> fetchRecords(){
        try {
            List<Member__c> conList = new List<Member__c>();
 
            conList = [Select id, First_Name__c, Email__c,Area__c,Membership_Plan__c,Membership_Start_Date__c,Membership_End_Date__c,Time_Slot__c from Member__c];              
            return conList;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
 
    @AuraEnabled
    public static String sendPdf(String contactId) {
        PageReference pdf = new pagereference('/apex/ContactDataPDF?id='+contactId);
        pdf.getParameters().put('id', contactId);
     
        Blob body;
        try {
            // returns page as a PDF
            body = pdf.getContent();
        } catch (Exception e) {
            body = Blob.valueOf('data');
        }
 
        //insert content version
        ContentVersion CV = new ContentVersion();
        CV.Title = 'TechdicerContact.pdf';
        CV.PathOnClient = 'TechdicerContact.pdf';
        CV.VersionData = body;
        CV.FirstPublishLocationId = contactId;
        insert CV;
         
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('TechdicerContact.pdf');
        attach.Body = body;
 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'shankarece007@gmail.com'});
        mail.setSubject('Generate PDF from Apex Salesforce');
        mail.setHtmlBody('Generate PDF from Apex Salesforce');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach}); 
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        return 'Email sent Successfully with PDF.';
    }
}