public with sharing class NFTService {
    private static final String NAMED_CRED = 'Infura_Polygon';

    /*
        * Checks if a wallet owns at least 1 of a specific ERC-1155 token.
        * @param walletAddress The wallet address (0x...)
        * @param contractAddress The NFT contract address (0x...)
        * @param tokenId The ERC-1155 tokenId to check
        * @return true if wallet owns token, false otherwise
     */

    @AuraEnabled(cacheable = true)
    public static Boolean hasValidNFT(String walletAddress, String contractAddress, String tokenId){
        if(String.isBlank(walletAddress) || String.isBlank(contractAddress) || String.isBlank(tokenId)){
            throw new AuraHandledException('Wallet, contract, and tokenId are required.');
        }

        try{
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('callout:'+ NAMED_CRED);
            req.setHeader('Content-Type', 'application/json');

            String dataField = encodeBalanceOf(walletAddress,tokenId);

            String body = JSON.serialize(new Map<String, Object>{
                'jsonrpc' => '2.0',
                'method' => 'eth_call',
                'params' => new List<Object>{
                    new Map<String, Object>{
                        'to' => contractAddress,
                        'data' => dataField
                    },
                    'latest'
                } ,
                'id' => 1
            });

            req.setBody(body);

            Http http = new Http();
            HttpResponse res = http.send(req);

            if(res.getStatusCode() == 200){
                Map<String, Object> jsonRes = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                if(jsonRes.containsKey('result')){
                    String hexBalance = (String) jsonRes.get('result');
                    if(String.isNotBlank(hexBalance) && hexBalance.startsWith('0x')){
                        String cleanHex = hexBalance.replace('0x','');
                        Decimal balance = hexToDecimal(cleanHex);
                        return balance>0;
                    }
                }
            }
            else{
                System.debug('NFT API call failed: '+ res.getStatus() + ' ' + res.getBody());
            }
        }
        catch (Exception e){
           System.debug('Error verifying NFT: ' + e.getMessage());
        }
        return false;
    }

    //ERC1155 balanceOf(address,unit256) -> function selector 0x00fdd58e
    private static String encodeBalanceOf(String walletAddress, String tokenId){
        //pay wallet address
        String cleanAddr = walletAddress.replace('0x', '').toLowerCase();
        while(cleanAddr.length() <64){
            cleanAddr = '0' + cleanAddr;
        }

        //convert tokenId -> hex
        String hexTokenId;
        if(tokenId.startsWith('0x')){
            hexTokenId = tokenId.replace('0x', '').toLowerCase();
        }
        else{
            hexTokenId = longToHex(Long.valueOf(tokenId));
        }
        while(hexTokenId.length()< 64){
            hexTokenId = '0' + hexTokenId;
        }
        return '0x00fdd58e' + cleanAddr + hexTokenId;
    }

    //Convert decimal string -> hex string
    private static String longToHex(Long val){
        if(val == null){
            return '0';
        }
        // if(val == null) return '0';
        String digits = '0123456789abcdef';
        String result = '';
        Long num = val;
        if(num == 0){
            return '0';
        }
        // if(num == 0) return '0';
        while(num>0){
            Integer remainder = Integer.valueOf(Math.mod(num,16));
            result = digits.substring(remainder,remainder+1) + result;
            num = (num - remainder) /16;
        }
        return result;
    }
        
    //Convert a hex string into a Decimal value
    private static Decimal hexToDecimal(String hex){
        hex = hex.toLowerCase();
        String digits = '0123456789abcdef';
        Decimal val = 0;
        for(Integer i=0;i<hex.length();i++){
            String c = hex.substring(i,i+1);
            Integer d = digits.indexOf(c);
            val = val*16 + d;
        }
        return val;
    }
}