trigger EventoOradorTrigger on EventoOrador__c (before insert, before update) {
    // Conjunto para armazenar os IDs dos oradores
    Set<Id> oradorIds = new Set<Id>();
    // Conjunto para armazenar os IDs dos oradores que possuem eventos
    Set<Id> setOradorhasEvent = new Set<Id>();
    // Itera sobre os registros a serem inseridos ou atualizados
    for (EventoOrador__c eventoOrador : Trigger.new) {
        // Adiciona os IDs dos oradores ao conjunto    
        oradorIds.add(eventoOrador.Orador__c);    
    }
    // Consulta para verificar se algum dos oradores já possui eventos registrados
    for (EventoOrador__c eventoOrador : [SELECT Id, Orador__c FROM EventoOrador__c WHERE Orador__c IN :oradorIds]){
        
        setOradorhasEvent.add(eventoOrador.Orador__c);
    }  
    // Itera novamente sobre os registros a serem inseridos ou atualizados
    for (EventoOrador__c eventoOrador : Trigger.new) {
        // Verifica se o orador já possui um evento registrado
        if (setOradorhasEvent.contains(eventoOrador.Orador__c)) {
            eventoOrador.Orador__c.addError('Este orador já possui um evento registrado.');
        }
    }
}