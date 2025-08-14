@isTest
public class TestDataHelpers {
    /**
     * @param setCountry
     * @param country
     */
    public static Account genAccountWithOptions(
        Boolean setCountry,
        String country
    ) {
        Account acct = new Account(
            Name = 'The Test Account of Awesomeness' +
                Crypto.getRandomInteger(),
            ShippingStreet = '123 Sessame St.',
            ShippingCity = 'Wehawkin'
        );

        if (setCountry) {
            acct.ShippingCountry = country;
        }
        return acct;
    }
}
