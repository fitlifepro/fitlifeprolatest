trigger MemberTrigger on Account (after insert, after update) {
    MemberTriggerHandler obj=new MemberTriggerHandler();
    obj.doAction();
}