from base_page import BasePage
from create_experiment_page import CreateExperimentPage
from view_experiment_page import ViewExperimentPage


class ExperimentHomepage(BasePage):

    def click_new_sdm_experiment(self):
        self.driver.find_element_by_link_text("new SDM Experiment").click()
        create_experiment_page = CreateExperimentPage(self.driver)
        return create_experiment_page

    def click_existing_experiment(self, path):
        self.driver.find_element_by_xpath("//a[@href='http://bccvl-qa.intersect.org.au/experiments/"+ path + "']").click()
        view_experiment_page = ViewExperimentPage(self.driver)
        return view_experiment_page