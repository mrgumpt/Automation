package seleniumAula3;

import org.junit.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;


public class LoginTest {
	@Test
	public void test() {
		//salvar variavel com nome do caminho do chromedriver
		String chromeDriverPath = "drivers/chromedriver.exe";
		
		// falar para o windows o caminho do chromedriver
		
		System.setProperty("webdriver.chrome.driver", chromeDriverPath);
		
		WebDriver selenium = new ChromeDriver();
		
		selenium.get("https://automationexercise.com/");
		
		
	}
	
}
