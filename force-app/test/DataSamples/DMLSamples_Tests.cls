@isTest
public class DMLSamples_Tests {
    @isTest
    static void testInsertInSystemModePositive() {
        Test.startTest();
        Account insertedAccount = DMLSamples.insertAccountViaInsertKeywordInSystemMode(
            'testAccount'
        );
        Test.stopTest();

        Account acct = [
            SELECT Name
            FROM Account
            WHERE Id = :insertedAccount.Id
        ];
        System.Assert.areEqual(
            'testAccount',
            acct.Name,
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertInSystemModeNegative() {
        Test.startTest();
        try {
            DMLSamples.insertAccountViaInsertKeywordInSystemMode(null);
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLSamples.CustomDMLException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('Failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testInsertInUserModeNegative() {
        Test.startTest();
        try {
            DMLSamples.insertAccountViaInsertKeywordInUserMode(null);
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLSamples.CustomDMLException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('Failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testInsertInUserModePositive() {
        Test.startTest();
        Account insertedAccount = DMLSamples.insertAccountViaInsertKeywordInUserMode(
            'testAccount'
        );
        Test.stopTest();

        Account acct = [
            SELECT Name
            FROM Account
            WHERE Id = :insertedAccount.Id
        ];
        System.Assert.areEqual(
            'testAccount',
            acct.Name,
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testDatabaseMethodInsertInSystemModePositive() {
        Test.startTest();
        DMLSamples.insertAccountsViaDatabaseMethod(
            new List<String>{ 'Texas' },
            false,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        List<Account> accts = [
            SELECT Id, Name
            FROM Account
        ];

        System.Assert.areEqual(
            1,
            accts.size(),
            'Expected the list of accounts to have a single account'
        );
        System.Assert.areEqual(
            'Texas',
            accts[0].Name,
            'Expected the account name to be Texas'
        );
    }
}
