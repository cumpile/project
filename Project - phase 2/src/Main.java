
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws  Exception{

        CodeScanner scanner = new CodeScanner( new FileReader("src/b.txt"));
        parser parser = new parser(scanner);
        parser.parse();
        System.out.println("ok");
    }
}
