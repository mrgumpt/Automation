from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import org.openqa.selenium.support.ui.Select


class Test_CURA:
    driver = ''
    chrome_options = Options()
    chrome_options.add_experimental_option("detach", True)
    def setup_method(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(5)
        self.driver.get('https://katalon-demo-cura.herokuapp.com/')

    def test_firsttest(self):
        #click appointment
        self.driver.find_element(By.ID, 'btn-make-appointment').click()

        username = self.driver.find_element(By.XPATH,'//*[@id="login"]/div/div/div[2]/form/div[1]/div[1]/div/div/input').get_property('value')
        password = self.driver.find_element(By.XPATH, '//*[@id="login"]/div/div/div[2]/form/div[1]/div[2]/div/div/input').get_property('value')

        self.driver.find_element(By.ID, 'txt-username').send_keys(username)
        self.driver.find_element(By.ID, 'txt-password').send_keys(password)
        self.driver.find_element(By.ID, 'btn-login').click()

        dropdown = self.driver.find_element(By.ID, 'combo_facility')
        dropdown.selectByIndex(1)



        self.driver.set_script_timeout(5)
