from base_page import BasePage
from view_experiment_page import ViewExperimentPage


class CreateExperimentPage(BasePage):

    def select_configuration(self):
        self.driver.find_element_by_link_text("Configuration").click()
        self.driver.implicitly_wait(100)

    def select_occurrences(self):
        self.driver.find_element_by_link_text("Occurrences").click()
        self.driver.implicitly_wait(100)

    def select_absences(self):
        self.driver.find_element_by_link_text("Absences").click()
        self.driver.implicitly_wait(100)

    def select_environment(self):
        self.driver.find_element_by_link_text("Environment").click()
        self.driver.implicitly_wait(100)

    def select_review(self):
        self.driver.find_element_by_link_text("Review").click()
        self.driver.implicitly_wait(100)

    def enter_experiment_name(self, name):
        self.driver.find_element_by_name("form.widgets.IDublinCore.title").clear()
        self.driver.find_element_by_name("form.widgets.IDublinCore.title").send_keys(name)

    def enter_experiment_description(self, description):
        self.driver.find_element_by_name("form.widgets.IDublinCore.description").clear()
        self.driver.find_element_by_name("form.widgets.IDublinCore.description").send_keys(description)
        self.driver.implicitly_wait(100)

    def select_sdm_algorithm_bioclim(self):
        self.driver.find_element_by_id("form-widgets-functions-0").click()

    def select_occurrences_data_for_abt(self):
        self.driver.find_element_by_id("form-widgets-species_occurrence_dataset-0").click()

    def select_review_start_experiment(self):
        self.driver.find_element_by_name("form.buttons.save").click()
        view_experiment_page = ViewExperimentPage(self.driver)
        return view_experiment_page