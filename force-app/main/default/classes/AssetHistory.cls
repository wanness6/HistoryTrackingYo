public with sharing class AssetHistory {
    @AuraEnabled(cacheable=true)
    public static List<Asset_History__c> getAssetHistory() {
        return [
            SELECT Object_Name__c, Field_Name__c, OldValue__c, NewValue__c
            FROM Asset_History__c
            WITH SECURITY_ENFORCED
        ];
    }
}
