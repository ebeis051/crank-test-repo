package test_java_git;

public class TestClass {

	public TestClass() {
		method();//I am not conflicting
	}
	
	private void method() {
		System.out.println("I'm printing a conflicting line");
	}
	
}
