List<Contact> conList = new List<Contact>{
    new Contact(FirstName = 'Joe', LastName = 'Smith', Department = 'Finance'),
    new Contact(FirstName = 'Jane', LastName = 'Doe', Department = 'HR'),
    new Contact(FirstName = 'Jim', LastName = 'Beam', Department = 'Sales'),
    new Contact()
};

// true: 全てロールバック、例外発生
// false: 失敗分のみロールバック、例外発生しない
Database.SaveResult[] srList = Database.insert(conList, false);

for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        System.debug(
            'Successfully inserted contact. Contact ID: ' + sr.getId()
        );
    } else {
        for (Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug(
                'Contact fields that affected this error: ' + err.getFields()
            );
        }
    }
}
