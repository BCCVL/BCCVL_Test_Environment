import os
from pages.base_page import BasePage
from pages.create_experiment_page import CreateExperimentPage
from pages.view_experiment_page import ViewExperimentPage



class ExperimentHomepage(BasePage):

    def click_new_sdm_experiment(self):
        self.driver.find_element_by_link_text("new SDM Experiment").click()
        create_experiment_page = CreateExperimentPage(self.driver)
        return create_experiment_page

    def click_existing_experiment(self, path):
        self.driver.find_element_by_xpath("//a[@href='" + os.environ['URL'] +"/experiments/"+ path + "']").click()
        view_experiment_page = ViewExperimentPage(self.driver)
        return view_experiment_page