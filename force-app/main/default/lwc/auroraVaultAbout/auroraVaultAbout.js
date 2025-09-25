import { LightningElement } from 'lwc';
import LEGACY_IMAGE from '@salesforce/resourceUrl/vault_Images';

export default class AuroraVaultAbout extends LightningElement {

     get legacyImage(){
        return LEGACY_IMAGE + '/Emmemobili.jpg';
     }
     get stanzaImage(){
        return LEGACY_IMAGE + '/stanza.jpg';
     }
}