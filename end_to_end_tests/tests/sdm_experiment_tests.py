import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import end_to_end_tests.config as config
from end_to_end_tests.pages.plone_homepage import PloneHomepage


class PloneTest(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.get(config.BASE_URL)
        self.driver.maximize_window()

    def test_create__bioclim_experiment(self):
        plone_homepage = PloneHomepage(self.driver)
        self.assertEqual(u'Welcome to BCCVL \u2014 Plone site', plone_homepage.title)

        bccvl_homepage = plone_homepage.valid_login('admin', 'admin')
        self.assertEqual("BCCVL Dashboard", bccvl_homepage.title)

        experiment_homepage = bccvl_homepage.click_experiments()
        self.assertEqual("BCCVL Experiment List", experiment_homepage.title)

        create_experiment_page = experiment_homepage.click_new_sdm_experiment()
        self.assertEqual("BCCVL New SDM Experiment", create_experiment_page.title)

        create_experiment_page.enter_experiment_name("New Experiment")
        create_experiment_page.enter_experiment_description("Experiment Description")
        create_experiment_page.select_configuration()
        create_experiment_page.select_sdm_algorithm_bioclim()
        create_experiment_page.select_occurrences()
        create_experiment_page.select_occurrences_data_for_abt()
        create_experiment_page.select_review()

        view_experiment_page = create_experiment_page.select_review_start_experiment()
        self.assertEqual("BCCVL Experiment Results", view_experiment_page.title)
        view_experiment_page.check_text_displayed("New Experiment")



    def tearDown(self):
        self.driver.close()