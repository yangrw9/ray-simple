
public class LearnAssignment {
    public static void main(String [ ] args) {
       Foo a = new Foo();
       Foo b = new Foo();
       a.str = "Come on...";
       a.value = 123;
       
       b = a;
       System.out.printf("b = {%s, %d} \n", b.str, b.value); // b = {Come on..., 123}
       
       b.str = "Baby baby...";
       Bar(b);
       System.out.printf("b = {%s, %d} \n", b.str, b.value); // b = {Baby baby, 123}

       Baz(b);
       System.out.printf("b = {%s, %d} \n", b.str, b.value); // b = {We are ..., 9}
       
       // Conclusion
       // 把 Java 函数参数，看做 C++ 指针 （而不是引用）
       // 
       //  Bar (Foo* f); // Java 这货 像这样！
       //
       //  Bar (Foo& f);
       //
    }
    static void Baz(Foo f)
    {
        Foo c = new Foo();
        c.str = "We are ...";
        c.value = 9;
        
        f.str = c.str;
        f.value = c.value;
    }
    
    static void Bar(Foo f)
    {
        Foo c = new Foo();
        c.str = "We are ...";
        c.value = 9;
        f = c;
    }
    
    static class Foo {
        public String str;
        public int value;
    }
}