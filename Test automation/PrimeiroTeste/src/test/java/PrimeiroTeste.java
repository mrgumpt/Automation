import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;

public class PrimeiroTeste {
	
	@Test
	public void teste() {
		String chromeDriverPath = "drivers/chromedriver.exe";

		System.setProperty("webdriver.chrome.driver", chromeDriverPath);

		WebDriver selenium = new ChromeDriver();
		
		try {
		selenium.get("https://mvnrepository.com/artifact/org.seleniumhq.selenium/selenium-java/4.25.0");

		String pageTitle = selenium.getTitle();

		//Assert.assertTrue(pageTitle.contains("Maven"));
		Assert.assertEquals(pageTitle, "maven");
		}
		finally {
		selenium.quit();
		}
	}
}