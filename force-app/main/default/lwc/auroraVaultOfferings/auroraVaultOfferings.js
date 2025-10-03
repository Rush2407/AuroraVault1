import { LightningElement } from 'lwc';
import imageResource from '@salesforce/resourceUrl/vault_Images';
export default class AuroraVaultOfferings extends LightningElement {
    get couponUrl(){
        return imageResource + '/Designer.png';
    }


    downloadImage() {
        fetch(imageResource)
            .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');
                link.href = url;
                link.download = 'downloaded-image.png';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                window.URL.revokeObjectURL(url);
            })
            .catch(error => {
                console.error('Error downloading image:', error);
            });
    }

}