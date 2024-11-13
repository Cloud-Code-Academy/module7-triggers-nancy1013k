trigger AccountTrigger on Account (before insert, after insert){

    if (Trigger.isBefore){
        for(Account acc : Trigger.New){
            if(acc.Type == null){
                acc.Type = 'Prospect';
            }
        }


        for(Account acc : Trigger.New){
            if (Trigger.isBefore && Trigger.isInsert){
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }


        for(Account acc : Trigger.New){
            if (acc.Phone != '' && acc.Website != '' && acc.Fax != ''){
                acc.Rating = 'Hot';
            }
        }
    }

    else if (Trigger.isAfter){
        List<Contact> contactsToInsert = new List<Contact>();
        for(Account acc : Trigger.New){
            Contact newContact = new Contact ();
            newContact.AccountId = acc.Id;
            newContact.LastName = 'DefaultContact';
            newContact.Email = 'default@email.com';
            contactsToInsert.add(newContact);
        }
            if (!contactsToInsert.isEmpty()) {
                insert contactsToInsert; 
            }
    }
}

