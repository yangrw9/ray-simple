
public class LearnAssignment {
    public static void main(String [ ] args) {
       Foo a = new Foo();
       Foo b = new Foo();
       a.str = "Come on...";
       a.value = 123;
       b = a;
       System.out.printf("b = {%s, %d}", b.str, b.value); // b = {Come on..., 123}
    }
    
    static class Foo {
        public String str;
        public int value;
    }
}