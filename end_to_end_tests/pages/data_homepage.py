from base_page import BasePage
from dataset_page import DatasetPage


class DataHomepage(BasePage):

    def new_dataset(self):
        dataset_page = DatasetPage(self.driver)
        return dataset_page