trigger FitnessTrainerTrigger on Fitness_Trainer__c (after insert, after update) {
    system.debug('Inside FitnessTrainerTrigger ');
    FitnessTrainerTriggerHandler trainerHandler = new FitnessTrainerTriggerHandler();
	trainerHandler.doAction();
}