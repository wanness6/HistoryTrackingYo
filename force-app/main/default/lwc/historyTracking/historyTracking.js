import { LightningElement, wire, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import getAssetHistory from '@salesforce/apex/AssetHistory.getAssetHistory';
export default class historyTracking extends LightningElement {
    @wire(getAssetHistory) assetHistory;
    @api recordId;
    @api error;

    //zorgt ervoor dat we weten welke record aangeduidt is.
    handleChange(event){
        this.recordId = event.target.value;
        console.log('@@@current RecordId@@@'+this.recordId);
    }

    //delete de record die aangeduidt is.
    handleDelete(){
        deleteRecord(this.recordId)
        .then(() => {
            return refreshApex(this.assetHistory);
        })
        .catch((error) => {
           this.error=error;
           console.log('unable to delete the record due to'+JSON.stringify(this.error));
        });
    }
}