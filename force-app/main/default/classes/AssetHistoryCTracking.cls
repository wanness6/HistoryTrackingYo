public with sharing class AssetHistoryCTracking {

    @InvocableMethod()
    public static void assetHistoryCTracking(List<SObject> recordList) {
        SObject previousRecord = recordList.get(0);
        String objectName = String.valueOf(previousRecord.getsobjecttype());



        YEPS__c fieldsToSave = [SELECT fields__c FROM YEPS__c LIMIT 1];
        List<String> fieldsToSaveList = new List<String>();

        List<String> splitFieldsToSave = fieldsToSave.fields__c.split(';');
        System.debug(splitFIeldsToSave);
        for(String cField: splitFieldsToSave){
            String cObject = cField.substringBefore('.');
            if(cObject == objectName){
                fieldsToSaveList.add(cField.substringAfter('.'));
            }
        }


        List<String> changedValues = new List<String>();

        String query = String.format('SELECT {0} FROM {1} WHERE Id={2}{3}{4} LIMIT 1', new String[] {String.join(fieldsToSaveList, ','),objectName, '\'', previousRecord.Id,'\''});
        SObject newRecord = Database.query(query);
        for(String fieldName: fieldsToSaveList) {
                if(previousRecord.get(fieldName) != newRecord.get(fieldName)){
                    createAssetHistoryCTrackingRecord(objectName ,fieldName, (String)previousRecord.get(fieldName), (String)newRecord.get(fieldName));
                }
        }
    }

    public static void createAssetHistoryCTrackingRecord(String objectName, String fieldName, String oldValue, String newValue){
        Asset_History__c newAH = new Asset_History__c();
        newAH.NewValue__c = newValue;
        newAH.OldValue__c = oldValue;
        newAH.Field_Name__c = fieldName;
        newAH.Object_Name__c = objectName;
        insert newAH;
    }
}
