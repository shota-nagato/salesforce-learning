public with sharing class DynamicSOQLRecipes {
    public static List<Account> simpleDynamicSOQL() {
        String queryString = 'SELECT Id FROM Account LIMIT 1';
        return Database.query(queryString, AccessLevel.USER_MODE);
    }
}
