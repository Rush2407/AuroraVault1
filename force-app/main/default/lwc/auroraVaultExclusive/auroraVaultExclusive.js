import { LightningElement,track } from 'lwc';
import hasValidNFT from '@salesforce/apex/NFTService.hasValidNFT';

export default class AuroraVaultExclusive extends LightningElement {


    @track walletAddress ='';
    @track hasAccess = false;
    @track errorMessage = '';
    @track isLoading = false;

    //Hardcode ERC-1155 details (replace with your NFT contract + tokenId)
    contractAddress = '0xf84Cc9421F26A002D450C05302c39041523000Aa';
    tokenId = '1'; //ERC-1155 token ID you want to check

    get isWalletValidLength(){
        return this.walletAddress && this.walletAddress.length === 42;
    }

    handleInput(event){
        this.walletAddress = event.target.value.trim();
        this.errorMessage = '';
        this.hasAccess = false;

    }

    async handleCheckNFT(){
        this.errorMessage = '';
        this.hasAccess = false;

        //Extra validation before sending to Apex
        if(!this.walletAddress.startsWith('0x') || this.walletAddress.length !== 42){
            this.errorMessage = 'Wallet address is incorrect';
            return;
        }

        this.isLoading = true;

        try{
            const result = await hasValidNFT({ 
                walletAddress : this.walletAddress,
                contractAddress : this.contractAddress,
                tokenId : this.tokenId
            });
            this.hasAccess = result;
            if(!result){
                this.errorMessage = 'NFT not found in this wallet.';
            }
        } 
        catch(error){
            this.errorMessage = 'Error: '+ (error.body ? error.body.message : error.message);
        }
        finally{
            this.isLoading = false;
        }
    } 

}