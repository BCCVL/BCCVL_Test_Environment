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

    def select_find_occurrences(self):
        self.driver.find_element_by_xpath("//a[@href='#tab-find']").click()

    def upload_new_dataset(self):
        self.driver.find_element_by_link_text("Upload New Dataset").click()

    def upload_data_file(self, path):
        self.driver.find_element_by_xpath("//input[@name='form.widgets.file']").send_keys(path)

    def select_dataset_type_special_occurrence(self):
        self.driver.find_element_by_xpath("//option[@id='form-widgets-http___namespaces_bccvl_org_au_prop_datagenre-6']").click()

    def enter_dataset_title(self, title):
        self.driver.find_element_by_name("form.widgets.IDublinCore.title").clear()
        self.driver.find_element_by_name("form.widgets.IDublinCore.title").send_keys(title)

    def enter_dataset_description(self, description):
        self.driver.find_element_by_name("form.widgets.IDublinCore.description").clear()
        self.driver.find_element_by_name("form.widgets.IDublinCore.description").send_keys(description)

    def select_upload_dataset(self):
        self.driver.find_element_by_name("form.buttons.save").click()

    def select_my_dataset(self):
        self.driver.find_element_by_link_text("My Datasets").click()