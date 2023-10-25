public class LeadTriggerHandler
{    
    public void doAction(List<Lead> triggerNew)
    {
        SWITCH on Trigger.operationType
        {
          WHEN BEFORE_INSERT
          {
              creatLeadValidation();
            }   
        }
       
   }
   public void creatLeadValidation()
   {
       
   }
    
}