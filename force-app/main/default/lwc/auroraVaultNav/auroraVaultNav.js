import { LightningElement } from 'lwc';
import LOGO from '@salesforce/resourceUrl/vault_Images';

export default class AuroraVaultNav extends LightningElement {

    get logo(){
        return LOGO + '/logo.png';
    }
}