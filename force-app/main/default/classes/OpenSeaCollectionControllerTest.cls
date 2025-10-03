@IsTest
private class OpenSeaCollectionControllerTest {

    // Mock class to simulate OpenSea API response
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"nfts": [{"id": "1", "name": "NFT One"}, {"id": "2", "name": "NFT Two"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    // Mock class to simulate failed response
    private class MockHttpErrorResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setBody('{"error": "Not Found"}');
            res.setStatusCode(404);
            return res;
        }
    }

    @IsTest
    static void testGetCollectionNftsSuccess() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        String response = OpenSeaCollectionController.getCollectionNfts('sample-collection');
        Test.stopTest();

        System.assertNotEquals(null, response, 'Response should not be null');
        System.assert(response.contains('NFT One'), 'Response should contain NFT One');
    }

}