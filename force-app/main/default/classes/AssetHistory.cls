public with sharing class AssetHistory {
    @AuraEnabled(cacheable=true)
    public static List<Asset_History__c> getAssetHistory() {
        List<Asset_History__c> acclist = [
            SELECT Id, Object_Name__c, Field_Name__c, OldValue__c, NewValue__c, Created_date__c
            FROM Asset_History__c
        ];
        return acclist;
    }
}
