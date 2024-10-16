package automationExercise;

import static org.junit.Assert.assertEquals;

import java.time.Duration;

import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.support.ui.Select;
import java.util.Random;



public class testlogin {
	
	    
	    
	        public static String getSaltString() {
	            String characters = "abcdefghijklmnopqrstuvwxyz0123456789";
	            Random random = new Random();

	            String username = random.ints(8, 0, characters.length())
	                                    .mapToObj(i -> "" + characters.charAt(i))
	                                    .reduce("", String::concat);
	                                    
	            String domain = random.ints(5, 0, 26)  // Only letters for domain
	                                  .mapToObj(i -> "" + characters.charAt(i))
	                                  .reduce("", String::concat);

	            return username + "@" + domain + ".com";
	        }
	
	

	
//	private final By directions = By.cssSelector(".google-symbols.Cw1rxd");
//    List<WebElement> directionsElements = driver.findElements(directions);
//
//
//
//    // Click on the first "google-symbols Cw1rxd" element
//    directionsElements.get(0).click();
//
//    private final By searchButton = By.id("search");
//    Boolean SearchDisplayed = driver.findElement(searchButton).isDisplayed();
//
//        element.isDisplayed();
//        element.isEnabled();
//        element.isSelected();
	
	
	
	
//	@Test
//	public void login() {
//
//		String chromeDriverPath = "drivers/chromedriver.exe";
//		System.setProperty("webdriver.chrome.driver", chromeDriverPath);
//
//		WebDriver selenium = new ChromeDriver();
//
//		selenium.get("https://automationexercise.com/");
//
//		// selenium.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
//
//		WebElement acceptCookies = new WebDriverWait(selenium, Duration.ofSeconds(20))
//				.until(ExpectedConditions.elementToBeClickable(By.xpath("//p[normalize-space()='Consent']")));
//		acceptCookies.click();
//
//		WebElement login = new WebDriverWait(selenium, Duration.ofSeconds(20))
//				.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[normalize-space()='Signup / Login']")));
//		login.click();
//
//
//		
//		WebElement email = new WebDriverWait(selenium, Duration.ofSeconds(20))
//				.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@data-qa='login-email']")));
//		email.sendKeys("rafaelferreirapt@gmail.com");
//		
//		WebElement password = new WebDriverWait(selenium, Duration.ofSeconds(20))
//				.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@placeholder='Password']")));
//		password.sendKeys("automation");
//		
//		
//		
//		WebElement loginButton = selenium.findElement(By.xpath("//button[normalize-space()='Login']"));
//
//		loginButton.click();
//
//		// verify the login text says 'Logged in as {username}'
//		WebElement loginTextField = selenium.findElement(By.cssSelector("li:nth-child(10) a:nth-child(1)"));
//
//		assertEquals(loginTextField.getText(), "Logged in as Rafa");
//
//		selenium.quit();
//
//	}
	
	@Test
	public void cadastrar() {
		
		
		
		
		String chromeDriverPath = "drivers/chromedriver.exe";
		System.setProperty("webdriver.chrome.driver", chromeDriverPath);

		WebDriver selenium = new ChromeDriver();

		selenium.get("https://automationexercise.com/");

		// selenium.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
		
		WebElement acceptCookies = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.xpath("//p[normalize-space()='Consent']")));
		acceptCookies.click();

		WebElement login = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[normalize-space()='Signup / Login']")));
		login.click();
		
		WebElement registerName = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("input[placeholder='Name']")));
		registerName.sendKeys("Carlos");
		
		
		WebElement registerEmail = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("input[data-qa='signup-email']")));	
		String emailRandom = "";
		emailRandom = getSaltString();
		registerEmail.sendKeys(emailRandom);
		
		WebElement signupButton = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button[data-qa='signup-button']")));	
		signupButton.click();	
		
		WebElement password = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#password")));	
		password.sendKeys("táflat");
		
		WebElement firstName = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#first_name")));	
		firstName.sendKeys("Carlos");
		
		WebElement lastName = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#last_name")));	
		lastName.sendKeys("Carvalho");
		
		WebElement adress = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#address1")));	
		adress.sendKeys("Carvalho");
		
		WebElement state = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#state")));	
		state.sendKeys("Lagos");
		
		WebElement city	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#city")));	
		city.sendKeys("Casa do Carlos Carvalho");
		
		WebElement zipcode	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#zipcode")));	
		zipcode.sendKeys("Casa do Miguel");
		
		WebElement mobileNumber	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#mobile_number")));	
		mobileNumber.sendKeys("999888777");
		
		WebElement createAccountNumber	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button[data-qa='create-account']")));	
		createAccountNumber.click();
		
		WebElement continueButton	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector(".btn.btn-primary")));	
		continueButton.click();
				
		WebElement loginTextField	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("li:nth-child(10) a:nth-child(1)")));	
		loginTextField.click();
		
		assertEquals(loginTextField.getText(), "Logged in as Carlos");
		
		
		
		WebElement logout	 = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.cssSelector("a[href='/logout']")));	
		logout.click();
		
		selenium.get("https://automationexercise.com/login");
		
		WebElement email = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@data-qa='login-email']")));
		email.sendKeys(emailRandom);
		
		WebElement passwordLogin = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@placeholder='Password']")));
		passwordLogin.sendKeys("táflat");
		
		WebElement loginButton = new WebDriverWait(selenium, Duration.ofSeconds(20))
				.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[normalize-space()='Login']")));
		loginButton.click();
		
		
		//selenium.quit();
		
	}
	
	
	
	
	
	
	
}