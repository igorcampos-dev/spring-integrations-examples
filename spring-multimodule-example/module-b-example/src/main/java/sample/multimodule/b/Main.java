package sample.multimodule.b;

public class Main {

    public static void main(String[] args) {
        Test test = new Test();
        test.print("Hello world from Module B");
    }

    public static class Test {

        public void print(String text){
            System.out.println(text);
        }

    }

}
