public with sharing class FitBitController {
    @AuraEnabled
    public  static String loginToFitBit(String CUserName,Date CDate){
     String s;
     String userDate;
         try {
        //    String Access_Token_Vijaya = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM1JCSzciLCJzdWIiOiI5WUs3QkciLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJzZXQgcm94eSBycHJvIHJudXQgcnNsZSByYWN0IHJyZXMgcmxvYyByd2VpIHJociBydGVtIiwiZXhwIjoxNzI4MTIzNDgzLCJpYXQiOjE2OTY1ODc0ODN9.Eq8F_Bs-VUzT08T_rAfbkHNzF5mH6rN6BCEzcH-0Zy4';
        //    String Access_Token_Swapna = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM1I5SkYiLCJzdWIiOiI5V004UzkiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJzZXQgcm94eSBybnV0IHJwcm8gcnNsZSByYWN0IHJyZXMgcmxvYyByd2VpIHJociBydGVtIiwiZXhwIjoxNzI4MzEyOTY3LCJpYXQiOjE2OTY3NzY5Njd9.byWsHv-eGxZ-AfdHy4NjzaclaePP1IwhBDzSM5ObLXk';
             Http http = new Http();
             Httprequest request = new Httprequest();
             system.debug('CUserName '+CUserName);
             system.debug('Current date: ' + String.valueOf(CDate).removeEnd(' 00:00:00'));
             userDate = String.valueOf(CDate).removeEnd(' 00:00:00');
             system.debug(userDate);
             system.debug('CDate' +CDate);
             request.setMethod('GET');
            if(CUserName.equals('Pavithra Chandrasekaran'))
             {
                 request.setHeader('Authorization', 'Bearer '+System.Label.Access_Token_Vijaya);
               //  request.setHeader('Authorization', 'Bearer ' +Access_Token_Vijaya);
             } 
             else if(CUserName.equals('Ramya P'))
             {
                request.setHeader('Authorization', 'Bearer '+System.Label.Access_Token_Swapna);
               //  request.setHeader('Authorization', 'Bearer ' +Access_Token_Swapna);
             } 
             
         //    request.setEndpoint('callout:FitBit1/-/activities/date/'+userDate+'.json');
          // request.setEndpoint('callout:FitBit/-/activities/date/'+userDate+'.json');
            request.setEndpoint('https://api.fitbit.com/1/user/-/activities/date/'+userDate+'.json');  
             Httpresponse response = http.send(request);
             s= response.getBody();
             System.debug('response' +response.getBody());
             System.debug('response' +response.getStatusCode());  
 
         } catch (Exception e) {
             throw new AuraHandledException(e.getMessage());
         }
         return s;
     }
 
    
 
}