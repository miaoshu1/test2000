import org.junit.Test;

import java.io.UnsupportedEncodingException;

public class Tester {
    @Test
    public void test01() throws UnsupportedEncodingException {
        String uri = "/abc.html.html";
        String viewName = uri.substring(1, uri.lastIndexOf(".html"));
        System.out.println(viewName);
    }
}
