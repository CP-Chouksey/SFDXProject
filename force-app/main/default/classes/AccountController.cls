public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Ids, Names, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

}
