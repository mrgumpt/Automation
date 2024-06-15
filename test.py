from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By

def test():
    driver = webdriver.Chrome()
    driver.implicitly_wait(5)

    driver.get('https://www.amazon.es/')
    search = driver.find_element(By.ID, 'twotabsearchtextbox')
    search.send_keys('guitar', Keys.ENTER)

    expected_text = '"guitar"'
    actual_text = driver.find_element(By.XPATH, "//span[@class='a-color-state a-text-bold']").text

    assert expected_text == actual_text, f'Error. Expected text "{expected_text}" but got "{actual_text}"'