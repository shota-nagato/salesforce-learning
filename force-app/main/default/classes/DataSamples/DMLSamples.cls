public with sharing class DMLSamples {
    public class CustomDMLException extends Exception {
    }

    /**
     * @param name name of the created account
     * @return the inserted Account
     */
    public static Account insertAccountViaInsertKeywordInSystemMode(
        String name
    ) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert as system acct;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return acct;
    }

    /**
     * @param name name of the created account
     * @return the inserted Account
     */
    public static Account insertAccountViaInsertKeywordInUserMode(String name) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert as user acct;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return acct;
    }

    /**
     * @param names
     * @param allOrNothing
     * @return list of inserted accounts
     */
    public static List<Account> insertAccountsViaDatabaseMethod(
        List<String> names,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        List<Account> accounts = new List<Account>();
        for (String name : names) {
            accounts.add(new Account(Name = name));
        }
        try {
            Database.insert(accounts, allOrNothing, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accounts;
    }
}
