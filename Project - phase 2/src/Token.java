

public class Token {
    TokenTypes tokenId;
    String tokenValue;
    public Token (TokenTypes key) {

        this.tokenId = key;
    }
    public Token (String value) {

        this.tokenValue = value;
    }
    public Token (TokenTypes key , String value){
        this.tokenId = key;
        this.tokenValue = value;
    }
}
