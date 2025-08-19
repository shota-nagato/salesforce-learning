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
}
