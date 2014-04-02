import hashlib

from pages.base_page import BasePage


class ViewExperimentPage(BasePage):
    def test(self):
        pass

    def select_results(self):
        self.driver.find_element_by_link_text("Results").click()

    def select_details(self):
        self.driver.find_element_by_link_text("Details").click()

    def downalod_experiment_results(self, file_name):
        self.driver.find_element_by_xpath("//a[@data-friendlyname='a_experimentoutput_" + file_name + "']").click()

    def generate_checksum(self, file_path):
        f = open(file_path) #change path
        m = hashlib.md5()
        m.update(f.read())
        file_checksum = m.digest()

        return file_checksum





