global class ApprovalEmailHandler implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        try {
            String subject = email.subject != null ? email.subject.trim() : '';
            System.debug('Incoming Email Subject: ' + subject);

            if (String.isNotBlank(subject)) {
                List<String> parts = subject.split(' ', 2);

                if (parts.size() == 2) {
                    String action = parts[0].toLowerCase();   
                    String recordId = parts[1];              

                    if (recordId.startsWith('001')) {
                        Account acc = [SELECT Id, Name, Status__c FROM Account WHERE Id = :recordId LIMIT 1];

                        String statusValue;
                        if (action == 'approve' || action == 'approved') {
                            acc.Status__c = 'Approved';
                            statusValue = 'Approved';
                        } else if (action == 'reject' || action == 'rejected') {
                            acc.Status__c = 'Rejected';
                            statusValue = 'Rejected';
                        }

                        update acc;
                        System.debug('Updated Account: ' + acc.Id + ' with Status: ' + acc.Status__c);
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(new String[] { envelope.fromAddress });
                        mail.setSubject('Account ' + statusValue);
                        mail.setPlainTextBody('Hello, the Account ' + acc.Name + ' has been ' + statusValue + '.');
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error in Email Handler: ' + e.getMessage());
            result.success = false;
        }

        return result;
    }
}