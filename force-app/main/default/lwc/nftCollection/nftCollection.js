import { LightningElement, track} from "lwc";
import getCollectionNfts from '@salesforce/apex/OpenSeaCollectionController.getCollectionNfts';

export default class NftCollection extends LightningElement{    
    @track nfts = [];
    @track slug = 'thevisitors';
    @track isShowModal = false;
    @track isLoading = false;

    nftName
    nftImage
    nftDescription
    

    // search functionality using "onkeyup"
    // handleKey(event){
    //     this.slug = event.target.value;
    //     console.log(event.key);
    //     if(event.key === "Enter"){
    //         this.loadNFTs();
    //     }
    // }
    connectedCallback(){
        this.loadNFTs();
    }

    //search functionality using Debouncing
    handleKey(event){
        this.slug = event.target.value;
        window.clearTimeout(this.timer);
        this.isLoading = true;
        this.timer = setTimeout(()=>{
                this.loadNFTs(); 
        },3000)
    }

    handleClick(){
        window.history.back();
        const exclusivePage = '/exclusive'; 
        window.location.href = exclusivePage;
    }

    //to show the modal
    showModalBox(event) {  
        this.isShowModal=true;
       
        const clickedIdentifier = event.currentTarget.dataset.id;
        this.nfts.forEach(nft => {
            if(nft.identifier == clickedIdentifier){
                this.nftName = nft.name;
                this.nftImage = nft.image_url
                this.nftDescription = nft.description;
            }
        });  
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    //function to load nfts
    loadNFTs(){
        getCollectionNfts({collectionSlug : this.slug})
        .then(result => {
           const data = JSON.parse(result);
           this.nfts = data.nfts; 
        })
        .catch( error =>{
            if(error)
                this.template.querySelector('c-custom-toast').show();
        })
        .finally(()=>{
            this.isLoading = false;
        });
    }    
}