from base_page import BasePage
from experiment_homepage import ExperimentHomepage
from data_homepage import DataHomepage

class BCCVLHomepage(BasePage):

    def click_experiments(self):
        self.driver.find_element_by_link_text("Experiments").click()
        experiment_homepage = ExperimentHomepage(self.driver)
        return experiment_homepage

    def click_data(self):
        self.driver.find_element_by_link_text("Data").click()
        data_homepage = DataHomepage(self.driver)
        return data_homepage
