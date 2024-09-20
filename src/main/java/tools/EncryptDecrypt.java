package tools;

import java.util.Base64;

public class EncryptDecrypt {

    // Encode a string to base64
    public static String encodeBase64(String data) {
        if (data == null) {
            return null;
        }
        return Base64.getEncoder().encodeToString(data.getBytes());
    }

    // Decode a base64 string
    public static String decodeBase64(String encodedData) {
        if (encodedData == null) {
            return null;
        }
        byte[] decodedBytes = Base64.getDecoder().decode(encodedData);
        return new String(decodedBytes);
    }
}
