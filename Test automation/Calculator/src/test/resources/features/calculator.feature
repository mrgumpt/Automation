Feature: Calculator

	@soma
  Scenario: Add two numbers
    Given I have a calculator
    When I add 2 and 2
    Then the result should be 4
    
    
	Scenario: Subtract two numbers
		Given I have a calculator
    When I subtract 2 and 2
    Then the result should be 0
    
  Scenario: Multiply two numbers
		Given I have a calculator
    When I multiply 2 and 2
    Then the result should be 4
    
  Scenario: Divide two numbers
		Given I have a calculator
    When I divide 2 and 2
    Then the result should be 1