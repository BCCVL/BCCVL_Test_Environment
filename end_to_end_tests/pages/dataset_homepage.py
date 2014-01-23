from base_page import BasePage


class DatasetHomepage(BasePage):

    def test(self):
        pass

    def enter_ala_search_string(self, name):
        self.driver.find_element_by_name("searchOccurrence_query").clear()
        self.driver.find_element_by_name("searchOccurrence_query").send_keys(name)

    def select_ala_dataset_to_download(self, name):
        self.driver.find_element_by_link_text(name).click()

    def select_download_dataset(self):
        self.driver.find_element_by_css_selector("i.icon-download-alt.icon-link").click()

    def check_import_message_displayed(self):
        self.driver.find_element_by_xpath("//*[contains(.,'Importing of this dataset has started')]")

    def check_species_selection(self, text):
        path_name = "//*[contains(.,'" + text + "')]"
        self.driver.find_element_by_xpath(path_name)
