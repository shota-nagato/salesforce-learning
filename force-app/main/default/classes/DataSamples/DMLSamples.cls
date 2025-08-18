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

    /**
     * @param acct
     * @return Upserted Account record
     */
    public static Account upsertAccountViaUpsertKeywordInSystemMode(
        Account acct
    ) {
        try {
            upsert as system acct;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw DMLe;
        }
        return acct;
    }

    /**
     * @param acct
     * @return Upserted Account record
     */
    public static Account upsertAccountViaUpsertKeywordInUserMode(
        Account acct
    ) {
        try {
            upsert as user acct;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw DMLe;
        }
        return acct;
    }

    /**
     * @param acct
     * @param allOrNothing
     * return Upsert operation result
     */
    public static Database.UpsertResult upsertAccountViaDatabaseMethod(
        Account acct,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.UpsertResult results;
            results = Database.upsert(acct, allOrNothing, accessLevel);
            return results;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @param accts
     * @return List of updated records
     */
    public static List<Account> updateAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via keyword';
        }
        try {
            update as system accts;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @param accts
     * @return List of updated records
     */
    public static List<Account> updateAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via keyword';
        }
        try {
            Database.update(accts, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @param accts
     */
    public static void deleteAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            delete as system accts;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @param accts
     */
    public static void deleteAccountViaKeywordInUserMode(List<Account> accts) {
        try {
            delete as user accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @param accts
     */
    public static void deleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.delete(accts, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @param accts
     * @return List of undeleted accounts
     */
    public static List<Account> undeletedAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            undelete as system accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @param accts
     * @return List of undeleted accounts
     */
    public static List<Account> undeleteAccountViaKeywordInUserMode(
        List<Account> accts
    ) {
        try {
            undelete as user accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @param accts
     * @return list of undeleted accounts
     */
    public static List<Account> undeleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.undelete(accts, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
}
