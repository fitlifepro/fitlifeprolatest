trigger MemberRevisedTrigger on Member__c (before insert, after insert, after update, after delete, after undelete) {   
    MemberRevisedTriggerHandler memberHandler = new MemberRevisedTriggerHandler();
    system.debug('Inside MemberRevisedTrigger');
    memberHandler.doAction();
}