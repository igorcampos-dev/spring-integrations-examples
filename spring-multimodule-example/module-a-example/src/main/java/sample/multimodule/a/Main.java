package sample.multimodule.a;

public class Main {

    public static void main(String[] args) {
        Test test = new Test();
        test.print("Hello world from Module A");
    }

    public static class Test {

        public void print(String text){
            System.out.println(text);
        }

    }

}
