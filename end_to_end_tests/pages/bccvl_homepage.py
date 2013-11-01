from base_page import BasePage
from experiment_homepage import ExperimentHomepage


class BCCVLHomepage(BasePage):

    def click_experiments(self):
        self.driver.find_element_by_link_text("Experiments").click()
        experiment_homepage = ExperimentHomepage(self.driver)
        return experiment_homepage
