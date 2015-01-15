package cn.yangrongwei.learn;

public class LearnPoly {

	class A {
		String name;
	}
	class B {
		String name;
	}
	
	<T> T getValue(T o) {	// (2)
		return o;
	}
	
	<T> void getRealClass(Object o) {	// (2)
		T a = (T)o;
	}
	
	public static void main(String[] args) {
		LearnPoly p = new LearnPoly();
		p.Dispatch();
	}
	
	void Dispatch() {
		Object obj1 = new A();	// (1)
		A a = new A();
		B b = new B();
		
		OnMessage(getValue(a));
		OnMessage(b);
		
		// 3)
		// OnMessage(obj1);				// invalid call
		// OnMessage(getValue(obj1));	// invalid call
		
		/* 
		  如何从一个 Object (1), 按其实际类型，多态分发到各个函数 ？
		  
		(2) 怎么办 ？？
		  
		  
		 */
	}
	
	void OnMessage(A a) {
		System.out.println("AAA");
	}
	
	void OnMessage(B b) {
		System.out.println("BBB");
	}

}
