import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By

class Test_nav_cart:
    driver = ''
    def setup_method(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(5)
        self.driver.get('https://www.amazon.es/')

    def test_shop_cart(self):
        self.driver.find_element(By.ID, 'nav-cart').click()
        actual_text = self.driver.find_element(By.XPATH, '//*[@id="sc-empty-cart"]/div[2]/div[1]/h2').text
        expected_text = 'Tu cesta de Amazon está vacía'

        assert expected_text == actual_text, f'Expected text "{expected_text}" but got "{actual_text}"'

        actual_items = self.driver.find_element(By.XPATH, '//*[@id="nav-cart-count"]').text
        expected_items = '0'
        assert expected_items == actual_items, f'Expected "{expected_items}" but got "{actual_items}"'


    def teardown_method(self):
        self.driver.quit()