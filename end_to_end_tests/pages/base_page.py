from selenium.webdriver.support.ui import WebDriverWait


class BasePage():
    def __init__(self, driver):
        self.driver = driver
        self.title = driver.title

    def check_text_displayed(self, string):
        assert string in self.driver.find_element_by_tag_name("body").text

    def wait_till_text_displayed(self, string, seconds):
      try:
         print "about to look for element"
         element = WebDriverWait(self.driver, seconds).until(lambda s: self.check_text_exists(string))
      finally:
          print 'found string'

    def check_text_exists(self, text):
        self.driver.refresh()
        element = self.driver.find_element_by_tag_name("body")
        if text in element.text:
            return True
        else:
            return False



