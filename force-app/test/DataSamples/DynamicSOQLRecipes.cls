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
}
