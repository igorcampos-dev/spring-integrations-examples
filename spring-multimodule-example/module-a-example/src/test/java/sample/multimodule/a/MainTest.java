package sample.multimodule.a;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

public class MainTest {

    @Test
    @DisplayName("Should print text without throwing any exception")
    void shouldPrintTextWithoutErrors() {
        Main.Test test = new Main.Test();
        assertDoesNotThrow(() -> test.print("Hello world from Module A"));
    }

}