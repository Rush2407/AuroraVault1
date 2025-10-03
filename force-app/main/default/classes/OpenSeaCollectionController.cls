public with sharing class OpenSeaCollectionController {
    @AuraEnabled(cacheable=true)
    public static string getCollectionNfts(String collectionSlug){
        HttpRequest req = new HttpRequest();
        String endpoint = 'callout:OpenSea/api/v2/collection/' + collectionSlug + '/nfts' ;
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200){
            return res.getBody();
        } else {
            throw new AuraHandledException('OpenSea API call failed: ' + res.getStatusCode() + ' - ' + res.getBody());
        }
    }
}