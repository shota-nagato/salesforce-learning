@isTest
private inherited sharing class DynamicSOQLRecipes_Tests {
    @TestSetup
    static void makeData() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Japan');
        insert acct;
    }

    @isTest
    static void simpleDynamicSOQLQueryTest() {
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleDynamicSOQL();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find single account'
        );
        Test.stopTest();
    }

    @isTest
    static void simpleDynamicSOQLQueryTestPositive() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name;
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find single account'
        );
    }

    @isTest
    static void simpleBindingSOQLQueryTestNegative() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name + '\'';
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.Assert.areEqual(
            0,
            results.size(),
            'Expected to fail to find an account'
        );
    }

    @isTest
    static void dynamicFieldsBindingSOQLQueryTestPositive() {
        Account acct = [SELECT Name FROM Account LIMIT 1];
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(
            acct
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find an Account'
        );
    }
}
