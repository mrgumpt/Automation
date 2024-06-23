from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class TestMyVM:
    driver = ''

    def setup_method(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(5)
        self.driver.get('https://rferreira-dev.finesource.org/login.html')

    def testMyVM(self):

        email = self.driver.find_element(By.XPATH,"//input[@name='email']")
        password = self.driver.find_element(By.XPATH,"//input[@name='password']")

        email.send_keys('teste@rferreira-dev.go-contact.com', Keys.ENTER)
        password.send_keys('gocontact', Keys.ENTER)
        wait = WebDriverWait(self.driver, 10)

        expected_text = 'teste'
        username_element = wait.until(EC.visibility_of_element_located((By.XPATH, "//span[@id='profile-userName']")))
        actual_text = username_element.text

        assert expected_text == actual_text, f'Error. {expected_text} is not equal to {actual_text}'

        open_menu = wait.until(EC.visibility_of_element_located((By.XPATH, "//i[@class='fa fa-arrow-circle-left hit']")))
        open_menu.click()

        open_voiceManager = wait.until(EC.visibility_of_element_located((By.XPATH, "//span[@class='menu-item-parent' and @data-translate='mainMenu.voiceManager']")))
        wait.until(EC.element_to_be_clickable(open_voiceManager)).click()

        outboundCampaignsCopy = wait.until(EC.visibility_of_element_located((By.XPATH,"//h2[@id='outboundCampaigns']")))
        actualCopy = outboundCampaignsCopy.text

        expected_copy = 'Outbound Campaigns'
        assert actualCopy == expected_copy, f'Error. {expected_copy} is not equal to {outboundCampaignsCopy}'

    def teardown_method(self):
        print("It's finished!")