public class NFTApiMock implements HttpCalloutMock {
    private Boolean owns;

    public NFTApiMock(Boolean ownsNFT){
        this.owns = ownsNFT;
    }

    public HTTPResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setStatusCode(200);

        if(owns){
            res.setBody('{"jsonrpc":"2.0","id":1,"result":"0x1"}');
        }
        else{
            res.setBody('{"jsonrpc":"2.0","id":1,"result":"0x0"}');
        }
        return res;
    }
}