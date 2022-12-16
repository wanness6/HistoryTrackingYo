import { LightningElement, wire } from 'lwc';
import OBJECTNAME from '@salesforce/schema/Asset_History__c.Object_Name__c';
import FIELDNAME from '@salesforce/schema/Asset_History__c.Field_Name__c';
import OLD_VALUE from '@salesforce/schema/Asset_History__c.OldValue__c';
import NEW_VALUE from '@salesforce/schema/Asset_History__c.NewValue__c';
import getAssetHistory from '@salesforce/apex/AssetHistory.getAssetHistory';
const COLUMNS = [
    { label: 'Object Name', fieldName: OBJECTNAME.fieldApiName, type: 'text' },
    { label: 'Field Name', fieldName: FIELDNAME.fieldApiName, type: 'text' },
    { label: 'Old value', fieldName: OLD_VALUE.fieldApiName, type: 'text' },
    { label: 'New value', fieldName: NEW_VALUE.fieldApiName, type: 'text' }

];
export default class historyTracking extends LightningElement {
    columns = COLUMNS;
    @wire(getAssetHistory)
    assetHistory;
}