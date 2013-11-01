from base_page import BasePage
from create_experiment_page import CreateExperimentPage


class ExperimentHomepage(BasePage):

    def click_new_sdm_experiment(self):
        self.driver.find_element_by_link_text("new SDM Experiment").click()
        create_experiment_page = CreateExperimentPage(self.driver)
        return create_experiment_page
