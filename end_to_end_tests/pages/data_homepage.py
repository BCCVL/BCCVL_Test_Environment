from pages.base_page import BasePage
from pages.dataset_homepage import DatasetHomepage


class DataHomepage(BasePage):

    def new_dataset(self):
        dataset_page = DatasetHomepage(self.driver)
        return dataset_page