import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import config

# This test confirms that the world is as we epxect it to be
class UnthemedPloneTest(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Firefox()

    def test_home_page_is_available(self):
        driver = self.driver
        driver.get(config.BASE_URL + "?diazo.off=1")
        self.assertIn("BCCVL", driver.title)

    def tearDown(self):
        self.driver.close()

