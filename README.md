# AuroraVault: NFT-Gated Access Portal (Web3 + Salesforce Experience Cloud)

## Overview

AuroraVault is a Luxury Brand Company that has developed a luxury brand portal using Salesforce Experience Cloud.  
This project enables users to access gated content on the Experience Cloud site only if they own a valid NFT (on Polygon) from the brand’s NFT collection. The project demonstrates advanced integration of Web3 (NFTs, Wallets, Smart Contracts) with Salesforce Experience Cloud for real-world luxury experiences.

---

## Technologies Used

- **Experience Cloud**
- **Apex**
- **Lightning Web Components (LWC)**
- **Web3 Integrations (Wallets, NFTs, Smart Contracts)**
- **OpenSea API**

---

## Key Features

1. **NFT Display from OpenSea on Salesforce Experience Cloud Site**  
   - Fetch and show NFTs from any OpenSea collection using the OpenSea v2 API.
   - Collection slug is user-configurable for dynamic data loading.

2. **Dynamic NFT Gallery with Lightning Web Components (LWC)**  
   - Interactive gallery/carousel to browse NFT images.
   - Click any NFT for full details in a modal (name, image, description, token ID, contract address).

3. **Dynamic Slug Input**  
   - User can input an OpenSea collection slug to view a different collection.

4. **Default Collection on Page Load**  
   - Loads a default NFT collection when the page first loads.
   - Updates the gallery when a new collection is searched.

5. **Loading Spinner**  
   - Visually engaging spinner is displayed during data fetching to indicate loading state.

6. **Custom Toast with Animation**  
   - If no NFTs are found, a custom animated toast notifies the user (e.g., “NFT not found”).

7. **Secure and Scalable API Integration**  
   - Uses Salesforce Named Credentials and External Credentials for secure API key management.
   - API key never exposed in client-side code.

8. **Permission Set & User Access**  
   - Custom permission set ensures only authorized users can access the API.

9. **CSP Trusted Site Configuration**  
   - Ensures images from OpenSea domains are allowed in Salesforce Experience Cloud sites (CSP settings).

10. **Custom Metadata & Labels**  
    - Easy configuration for contract address, token ID, and other parameters using Salesforce custom labels or metadata.

11. **Graceful Error Handling**  
    - Handles API errors, CSP issues, and empty collections gracefully with user-friendly messages and fallback UI.

---

## Pre-Requisites

Before starting implementation of this project, you need:

1. **MetaMask Wallet Address**
2. **NFT Contract Address & Token Id**
3. **Infura Key & Secret**
4. **OpenSea API Key**

---

## Download Resources

Download and create zip files named exactly as below and add them as static resources:

- `car_Images`
- `vault_Images`
- `watch_Images`

> These are uploaded under `force-app/main/default/staticresources`.

---

## Salesforce Org & Environment Setup

1. **Create a Salesforce Developer Org**  
   [Sign Up](https://developer.salesforce.com/developer-legacy/signup)

2. **Change the My Domain Name**
   - Log in to your Salesforce org (Developer Edition)
   - Go to Setup → Company Settings → My Domain → Edit & change the name to `auroravault`
   - Deploy your new domain

3. **Setup Your Salesforce Dev Hub**
   - Enable Dev Hub:  
     Setup → Dev Hub → Enable
   - Install Salesforce CLI (sf CLI) on your machine.
   
4. **Initialize Your Project Locally**
   - Create project folder:
     ```sh
     sf project generate -n aurora-vault
     cd aurora-vault
     ```
   - Authenticate Dev Hub locally:
     ```sh
     sf org login web -d -a DevHub
     ```
     (`-d` sets it as default, `-a` is alias)
   - Connect & Open Dev Hub:
     ```sh
     sf org open -o AuroraVaultScratch
     ```

---

## Develop Project

### Steps

a) **Enable Digital Experiences**  
   - Setup → Search `Digital Experiences` → Settings → Enable Digital Experiences

b) **Create AuroraVault Site**  
   - New → Template “Build Your Own LWR” → Name: `auroravault`

c) **Upload Zip Folders as Static Resources**  
   - Upload `car_Images`, `watch_Images`, and `vault_Images` in Static Resources.

d) **Add “Server_Error” Image in Content Asset Library**  
   - App Launcher → Search Files → Library → Asset Library → Upload Asset File  
   - Asset file Name: `Server_Error`  
   - File Sharing: Select both options

e) **Create Custom Labels to Store Contract Address & Token Id**
   - Name: `contractAddress`  
     Value: `"Your nft contract address"`
   - Name: `tokenId`  
     Value: `"Your nft token Id"`

f) **Add Named Credentials for Infura**
   - Setup → Quick Find → Search `Named Credentials` → New Legacy
     - Label: `Infura Polygon`
     - Name: `Infura_Polygon`
     - URL: `https://polygon-mainnet.infura.io/v3/your_api_key`
     - Identity Type: Named Principal
     - Authentication Protocol: Password Authentication
     - UserName: Your Infura Polygon API Key
     - Password: Your Infura Polygon API Secret

g) **Create Remote Site Setting (optional but recommended)**
   - Setup → Remote Site Settings → New Remote Site
     - Remote Site Name: `OpenSea_API`
     - Remote Site URL: `https://api.opensea.io`
     - Save

h) **Add Named Credentials for OpenSea**

   1. **Store API Key Securely with External Credentials**
      - Setup → External Credentials → New
        - Label: `OpenSea_Credential`
        - Name: `OpenSea_Credential`
        - Authentication Protocol: Custom
      - Add Principal:
        - Principal Name: `OpenSea_Principal`
        - Authentication Parameters:  
          - Name: `X-API-KEY`  
          - Value: `your_opensea_api_key`
      - Add to Custom Headers

   2. **Map Permissions**
      - Setup → Permission Sets → Create Permission Set (e.g., `OpenSea_Access`)
      - External Credential Principal Access
      - Assign the External Credential (`OpenSea_Credential`) to it
      - Assign this Permission Set to logged-in User

   3. **Create Named Credential**
      - Setup → Named Credentials → New Named Credential
        - Label: `OpenSea`
        - Name: `OpenSea`
        - URL: `https://api.opensea.io`
        - Enabled for Callouts: Toggle ON
        - External Credential: Select `OpenSea_Credential`
        - Generate Authorization Header: **Uncheck**  
          (OpenSea expects `X-API-KEY` header, not standard OAuth.)
        - Save

i) **Create Pages, LWC Components, & Apex Classes**

1. **Setup Pages in Site**
   - Home → New Page → Standard Page → New Blank Page
     - Name: `Cars`         | url: `/cars`          | api name: `cars`
     - Name: `Watches`      | url: `/watches`       | api name: `watches`
     - Name: `About`        | url: `/about`         | api name: `about`
     - Name: `Careers`      | url: `/careers`       | api name: `careers`
     - Name: `Exclusive`    | url: `/exclusive`     | api name: `exclusive`
     - Name: `NFT Collections` | url: `/nft-collections` | api name: `nft_collections`

2. **Create & Add Components**
   - `auroraVaultNav`  
     _Add to Home Page → Theme Header Section_
   - `auroraVaultHome`  
     _Add to Home Page → Content Section_
   - `auroraVaultCars`  
     _Add to Cars Page → Content Section_
   - `auroraVaultWatches`  
     _Add to Watches Page → Content Section_
   - `auroraVaultAbout`  
     _Add to About Page → Content Section_
   - `auroraVaultCareers`  
     _Add to Careers Page → Content Section_
   - `customToast`
   - `nftCollection`  
     _Add to NFT Collections Page → Content Section_
   - `auroraVaultOfferings`
   - `auroraVaultExclusive`  
     _Add to Exclusive Page → Content Section_
   - On “Service Not Available” page:  
     Edit the markup:
     ```html
     <img src="{!contentAsset.Server_Error.1}" style="width:100%;"  />
     ```

3. **Create Apex Classes**
   - `NFTService.cls`
   - `NFTServiceTest.cls`
   - `NFTApiMock.cls`
   - `OpenSeaCollectionController.cls`
   - `OpenSeaCollectionControllerTest.cls`
   - _Add the contractAddress & tokenId of your NFT in `AuroraVaultExclusive` component JS file_

4. **Publish & Activate Site**

---

## References

- **Create Metamask Wallet:**  
  [YouTube Guide](https://youtu.be/-iwnN18Uzzw?si=B_yWmf9cF0iRvheQ)
- **How to create an NFT:**  
  [YouTube Guide](https://youtu.be/S306YeMqc1k?feature=shared)
- **Get Infura Polygon Credentials:**  
  [Infura.io](https://www.infura.io/)
- **Get an OpenSea API key:**  
  Request at OpenSea Dev Portal. You'll receive a key.
- **Reference Images:**  
  [Pixabay Luxury Car Images](https://pixabay.com/images/search/luxury%20car/)

---

## Notes

- Ensure all names and API keys/secrets are stored securely.
- For further assistance, consult Salesforce and OpenSea documentation.