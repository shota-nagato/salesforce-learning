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

    @isTest
    static void testDatabaseMethodInsertInSystemModeNegative() {
        Test.startTest();
        try {
            DMLSamples.insertAccountsViaDatabaseMethod(
                new List<String>{ 'Texas', null },
                true,
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLSamples.CustomDMLException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
            List<Account> accts = [
                SELECT Id, Name
                FROM Account
            ];
            System.Assert.areEqual(
                0,
                accts.size(),
                'Expected the no account record to be inserted'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');

        Test.startTest();
        DMLSamples.upsertAccountViaUpsertKeywordInSystemMode(acct);
        Test.stopTest();

        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE Name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with the name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        acct.Id = '0019A000008GTAYQA4'; //NOPMD
        Test.startTest();
        try {
            DMLSamples.upsertAccountViaUpsertKeywordInSystemMode(acct);
            System.Assert.fail('Expected DML Exception');
        } catch (DMLException dmlException) {
            System.Assert.isTrue(
                dmlException.getMessage()
                    .containsIgnoreCase('invalid cross reference id')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');

        Test.startTest();
        DMLSamples.upsertAccountViaUpsertKeywordInUserMode(acct);
        Test.stopTest();

        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE Name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        acct.Id = '0019A000008GTAYQA4'; //NOPMD
        Test.startTest();
        try {
            DMLSamples.upsertAccountViaUpsertKeywordInUserMode(acct);
            System.Assert.fail('Expected DML Exception');
        } catch (DMLException DMLe) {
            System.Assert.isTrue(
                DMLe.getMessage()
                    .containsIgnoreCase('invalid cross reference id')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        Database.UpsertResult result;
        Test.startTest();
        result = DMLSamples.upsertAccountViaDatabaseMethod(
            acct,
            true,
            AccessLevel.SySTEM_MODE
        );
        Test.stopTest();
        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE Name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }
}
