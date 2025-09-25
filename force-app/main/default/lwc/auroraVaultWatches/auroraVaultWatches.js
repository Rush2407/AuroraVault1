import { LightningElement } from 'lwc';
import WATCH_IMAGES from '@salesforce/resourceUrl/watch_Images';

export default class AuroraVaultWatches extends LightningElement {

    get watchImage5(){
        return WATCH_IMAGES + '/watch5.jpg';
    }
    get watchImage3(){
        return WATCH_IMAGES + '/watch3.png';
    }
    get watchImage8(){
        return WATCH_IMAGES + '/watch8.jpg';
    }
    get watchImage6(){
        return WATCH_IMAGES + '/watch6.png';
    }
    get watchImage7(){
        return WATCH_IMAGES + '/watch7.jpg';
    }

}