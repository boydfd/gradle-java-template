package com.aboydfd;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class AppTest {
    @Test
    void loadContext() {
        App.main(new String[]{});
    }
}
