package calculatorBdd.steps;


import static org.junit.Assert.assertEquals;

import calculatorPackage.Calculator;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;



public class CalculatorSteps {
	
	public Calculator calculator;
	public int result;
	
	@Given("I have a calculator")
	public void i_have_a_calculator() {
	    // 
	    calculator = new Calculator();
	}
	
	@When("I add {int} and {int}")
	public void i_add_and(int num1, int num2) {
	    // 
	    result = calculator.add(num1, num2);
	}
	
	@Then("the result should be {int}")
	public void the_result_should_be(int resultBDD) {

		assertEquals(result, resultBDD);
	}
	
	
	@When("I subtract {int} and {int}")
	public void i_subtract_and(int int1, int int2) {
	    // Write code here that turns the phrase above into concrete actions
	    result = calculator.subtract(int1, int2);
	}
	
	@When("I multiply {int} and {int}")
	public void i_multiply_and(int int1, int int2) {
	    // Write code here that turns the phrase above into concrete actions
	    result = calculator.multiply(int1, int2);
	}
	
	@When("I divide {int} and {int}")
	public void i_divide_and(int int1, int int2) {
	    result = calculator.divide(int1, int2);
	    
	}
	
	
}
