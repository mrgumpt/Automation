from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By

class TestAmazon:
    driver = ''
    def setup_method(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(5)
        self.driver.get('https://www.amazon.es/')

    def test_guitar(self):
        search = self.driver.find_element(By.ID, 'twotabsearchtextbox')
        search.send_keys('guitar', Keys.ENTER)

        expected_text = '"guitar"'
        actual_text = self.driver.find_element(By.XPATH, "//span[@class='a-color-state a-text-bold']").text

        assert expected_text == actual_text, f'Error. Expected text "{expected_text}" but got "{actual_text}"'
        print('Success!')

    def test_guitarPick(self):
        search = self.driver.find_element(By.ID, 'twotabsearchtextbox')
        search.send_keys('guitar pick', Keys.ENTER)

        expected_text = '"guitar pick"'
        actual_text = self.driver.find_element(By.XPATH, "//span[@class='a-color-state a-text-bold']").text

        assert expected_text == actual_text, f'Error. Expected text "{expected_text}" but got "{actual_text}"'

    def teardown_method(self):
        self.driver.quit()