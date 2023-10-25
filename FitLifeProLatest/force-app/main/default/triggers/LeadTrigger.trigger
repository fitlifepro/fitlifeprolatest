trigger LeadTrigger on Lead (before insert)
{
    LeadTriggerHandler leadHandler=new LeadTriggerHandler();
    leadHandler.doAction(Trigger.New);
}