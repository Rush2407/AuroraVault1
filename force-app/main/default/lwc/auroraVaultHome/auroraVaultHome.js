import { LightningElement } from 'lwc';
import AURORAVAULT_IMAGES from '@salesforce/resourceUrl/car_Images';
import EMAIL_ICON from '@salesforce/resourceUrl/vault_Images';

export default class AuroraVaultHome extends LightningElement {
    
    get carImage(){
        return AURORAVAULT_IMAGES + '/car1.jpg';
    }

    get email_Icon(){
        return EMAIL_ICON + '/email_chatter.svg';
    }
}