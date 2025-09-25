# AuroraVault1: NFT-Gated Access Portal (Web3 + Salesforce Experience Cloud)

## Overview

AuroraVault is a Luxury Brand Company that has developed a luxury brand portal using Salesforce Experience Cloud. This project enables users to access gated content on the Experience Cloud site only if their wallet holds a specific NFT.

## Technologies Used

- **Salesforce Experience Cloud**
- **Apex**
- **Lightning Web Components (LWC)**
- **Web3 Integrations** (Wallets, NFTs, Smart Contracts)
- **CI/CD Deployment** with GitHub Actions
- **Git & GitHub**

## Roles & Responsibilities

This project simulates a real-world deployment process, involving multiple roles:

- **DevOps**: Set up the GitHub repository (single source of truth), create a `dev` branch for developers, and configure a CI/CD pipeline to trigger deployments when PRs are merged to `main`.
- **Developer**: Build and customize the project in a Salesforce scratch org, push changes to the `dev` branch, and create pull requests for production deployment.
- **Release Management (RM)**: Deploy changes to the production (developer) org.

---

## Setup and Deployment Steps

### 1. Salesforce Developer Org Creation

- Sign up: [Salesforce Developer Sign Up](https://developer.salesforce.com/developer-legacy/signup)
- Change My Domain:  
  `Setup > Company Settings > My Domain > Edit`  
  Rename to `auroravault` and deploy.

### 2. Enable Dev Hub & Salesforce CLI

- `Setup > Dev Hub > Enable`
- Install [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)

### 3. Initialize Project Locally

```sh
sf project generate -n aurora-vault
cd aurora-vault
sf org login web -d -a DevHub
```

- Create `project-scratch-def.json` (see `Notes.txt` for sample)

### 4. Create Scratch Org & Push Source

```sh
sf org create scratch -f config/project-scratch-def.json -a AuroraVaultScratchOrg --duration-days 30 -d
sf org open -o AuroraVaultScratch
```

### 5. Version Control with GitHub

- Create a public GitHub repo: `AuroraVault1`
- Initialize Git locally:

```sh
git init
git branch -M main
git remote add origin https://github.com/<yourUsername>/AuroraVault1.git
git add .
git commit -m "Initial AuroraVault Portal commit"
git push -u origin main
git checkout -b dev
git push -u origin dev
```

### 6. Store Auth in GitHub Secrets

- Get your Dev Hub Auth URL:  
  `sf org display -o DevHub --verbose`
- Add to GitHub Secrets:  
  - Name: `SF_AUTH_URL`
  - Secret: *Your Sfdx Auth Url*

### 7. Setup GitHub Actions Workflow

- Create workflow file: `.github/workflows/deploy.yml`
- Add deployment logic (see `deploy.yml` in your notes)

### 8. Develop in Scratch Org

- Enable Digital Experiences:  
  `Setup > Digital Experiences > Settings > Enable`
- Create AuroraVault Site:  
  Template: "Build Your Own LWR"  
  Site name: `auroravault`
- Upload static resources (`car_Images`, `watch_Images`, `vault_Images`)
- Add "Server_Error" image to asset library.

#### Create Pages

- Home, Cars, Watches, About, Careers, Exclusive (with respective URLs and API names)

#### Create LWC Components & Apex Classes

- `auroraVaultNav` (theme header)
- `auroraVaultHome` (home page content)
- `auroraVaultCars` (cars page content)
- `auroraVaultWatches` (watches page content)
- `auroraVaultAbout` (about page content)
- `auroraVaultCareers` (careers page content)
- `auroraVaultExclusive` (exclusive page content)
- `auroraVaultOfferings`

#### Named Credentials

- Setup > Named Credentials > New Legacy  
  - Label: Infura Polygon
  - Name: Infura_Polygon
  - URL: `https://polygon-mainnet.infura.io/v3/<your_api_key>`
  - Username: Your Infura API key
  - Password: Your Infura API secret

#### Apex Classes

- `NFTService.cls`
- `NFTServiceTest.cls`
- `NFTApiMock.cls`

Add contractAddress & tokenId of your NFT in `AuroraVaultExclusive` component JS file.

#### Metadata Retrieval

```sh
sf project retrieve start --manifest manifest/package.xml
```

#### Commit Changes

```sh
git add .
git commit -m "Project deployment completed in scratch org"
```

---

### 9. Deploy to Production Org

- Push to `dev` branch:  
  `git push -u origin dev`
- Create a pull request and merge.
- CI/CD workflow will deploy metadata to production.

### 10. Production Setup (Manual After Deployment)

Repeat page and component additions as above in the production site.  
Publish & activate the site.

---

## References

- **NFT Creation Video:**  
  [How to create an NFT](https://youtu.be/S306YeMqc1k?feature=shared)
- **Get Infura Polygon Credentials:**  
  [Infura](https://www.infura.io/)
- **Reference Images:**  
  [Luxury Cars on Pixabay](https://pixabay.com/images/search/luxury%20car/)

---

## License

This project is open source and available under the MIT License.
