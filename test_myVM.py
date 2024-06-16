from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def testMyVM():
    driver = webdriver.Chrome()
    driver.implicitly_wait(5)
    wait = WebDriverWait(driver, 10)

    driver.get('https://rferreira-dev.finesource.org/login.html')
    email = driver.find_element(By.XPATH,"//input[@name='email']")
    password = driver.find_element(By.XPATH,"//input[@name='password']")

    email.send_keys('teste@rferreira-dev.go-contact.com', Keys.ENTER)
    password.send_keys('gocontact', Keys.ENTER)

    expected_text = 'teste'
    username_element = wait.until(EC.visibility_of_element_located((By.XPATH, "//div[@class='user-username']//span[@id='profile-userName']")))
    actual_text = username_element.text

    assert expected_text == actual_text, f'Error. {expected_text} is not equal to {actual_text}'