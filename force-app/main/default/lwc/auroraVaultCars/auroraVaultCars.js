import { LightningElement } from 'lwc';
import CAR_IMAGE from '@salesforce/resourceUrl/car_Images';

export default class AuroraVaultCars extends LightningElement {

    get carImage2(){
        return CAR_IMAGE + '/car2.webp';
    }
    get carImage3(){
        return CAR_IMAGE + '/car3.jpg';
    }
    get carImage4(){
        return CAR_IMAGE + '/car4.jpg';
    }
    get carImage5(){
        return CAR_IMAGE + '/car5.jpg';
    }
    get carImage6(){
        return CAR_IMAGE + '/car6.jpg';
    }

}