// customToast.js
import { LightningElement, api, track } from 'lwc';

export default class CustomToast extends LightningElement {
    @api message;
    @track variant = 'info';
    @track visible = false;

    @api show() {
        this.visible = true;
        setTimeout(() => {
            this.visible = false;
        }, 3000);
    }
}