import { LightningElement } from 'lwc';
import CAREER_IMAGE from '@salesforce/resourceUrl/vault_Images';

export default class AuroraVaultCareers extends LightningElement {

    get career_Image(){
        return CAREER_IMAGE + '/career.webp';
    }
}