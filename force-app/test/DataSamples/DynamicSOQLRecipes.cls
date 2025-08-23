public with sharing class DynamicSOQLRecipes {
    @SuppressWarnings('PMD.ApexSOQLInjection')
    public static List<Account> simpleDynamicSOQL() {
        String queryString = 'SELECT Id FROM Account LIMIT 1';
        return Database.query(queryString, AccessLevel.USER_MODE);
    }

    public static List<Account> simpleBindingSOQLQuery(String name) {
        Map<String, Object> nameBind = new Map<String, Object>{
            'name' => name
        };
        String queryString =
            'SELECT Id, Name ' +
            'FROM Account ' +
            'WHERE Name = :name';
        return Database.queryWithBinds(
            queryString,
            nameBind,
            AccessLevel.USER_MODE
        );
    }

    public static List<Account> dynamicFieldsBindingSOQLQuery(Account acct) {
        Map<String, Object> accountNameBind = new Map<String, Object>{
            'accountName' => acct.Name
        };
        String accountName = acct.Name;
        String queryString =
            'SELECT Id, Name ' +
            'FROM Account ' +
            'WHERE Name = :accountName';
        return Database.queryWithBinds(
            queryString,
            accountNameBind,
            AccessLevel.USER_MODE
        );
    }

    @SuppressWarnings('PMD.ApexSOQLInjection')
    public static List<Account> typecastDataIntelligently(
        String numberOfRecords
    ) {
        String queryString =
            'SELECT Id, Name FROM Account WHERE NumberOfEmployees > ' +
            String.valueOf(Integer.valueOf(numberOfRecords));
        return Database.query(queryString, AccessLevel.USER_MODE);
    }
}
