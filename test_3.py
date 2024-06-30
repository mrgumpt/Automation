from selenium import webdriver
from selenium.webdriver.common.by import By

class Test_bestsellers:
    driver = ''

    def setup_method(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(5)
        self.driver.get('https://www.amazon.es/')

    def test_bestsellers(self):
        self.driver.find_element(By.XPATH, '//*[@id="nav-xshop"]/a[2]').click()

        actual_links = self.driver.find_elements(By.XPATH, '//*[@id="zg_header"]/div//li')

        assert len(actual_links) == 5, f'Expected 5 links, got {len(actual_links)}'


    def teardown_method(self):
        self.driver.quit()