@isTest
public class NFTServiceTest {
    @isTest 
    static void testHasValidNFTOwnsNFT(){
        Test.setMock(HttpCalloutMock.class, new NFTApiMock(true));

        Boolean result = NFTService.hasValidNFT(
            '0x1234567890abcdef1234567890abcdef12345678',
            '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd',
            '1'
        );
        System.assertEquals(true,result,'User should have NFT access');
    }

    @isTest 
    static void testHasValidNFTNoNFT(){
        Test.setMock(HttpCalloutMock.class, new NFTApiMock(false));

        Boolean result = NFTService.hasValidNFT(
            '0x1234567890abcdef1234567890abcdef12345678',
            '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd',
            '1'
        );
        System.assertEquals(false,result,'User should not have NFT access');
    }
}