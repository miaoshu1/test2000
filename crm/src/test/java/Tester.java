import com.bjpowernode.crm.mapper.ClueMapper;
import com.bjpowernode.crm.pojo.Clue;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.UUID;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class Tester {

    @Autowired
    private ClueMapper clueMapper;

    @Test
    public void test01() {
        for (int i = 0; i < 123; i++) {
            Clue clue = new Clue();

            clue.setId(UUIDUtil.getUUID());
            clue.setFullName("线索" + i);
            clue.setCompany("动力节点");
            clue.setPhone("123");
            clue.setMphone("456");
            clue.setSource("广告");
            clue.setState("02需求分析");
            clue.setOwner("1000|张三");
            clueMapper.save(clue);
        }
    }
}
