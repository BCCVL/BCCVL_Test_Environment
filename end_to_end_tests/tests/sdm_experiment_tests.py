import unittest
from selenium import webdriver
import end_to_end_tests.config as config
from selenium.webdriver.support.ui import WebDriverWait
import tempfile
from end_to_end_tests.pages.plone_homepage import PloneHomepage


class SDMExperimentTests(unittest.TestCase):

    def setUp(self):
        fp = webdriver.FirefoxProfile()
        temp_dir = tempfile.mkdtemp()
        print temp_dir
        fp.set_preference("browser.download.dir", temp_dir)
        fp.set_preference("browser.helperApps.neverAsk.openFile", "application/zip")
        fp.set_preference("browser.helperApps.neverAsk.saveToDisk", "application/zip")
        fp.set_preference("browser.download.folderList", 2)
        self.driver = webdriver.Firefox(firefox_profile=fp)
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
        create_experiment_page.enter_experiment_name("ABT bioclim model and evaluation")
        create_experiment_page.enter_experiment_description("ABT bioclim model, current projection, and model evaluation")
        create_experiment_page.select_configuration()
        create_experiment_page.select_sdm_algorithm_bioclim()
        create_experiment_page.select_occurrences()
        create_experiment_page.select_occurrences_data_for_abt()
        create_experiment_page.select_absences()
        create_experiment_page.select_absences_data_for_abt()
        create_experiment_page.select_environment()
        create_experiment_page.select_current_climate_layers()
        create_experiment_page.select_review()
        view_experiment_page = create_experiment_page.select_review_start_experiment()
        self.assertEqual("BCCVL Experiment Results", view_experiment_page.title)
        view_experiment_page.check_text_displayed("ABT bioclim model and evaluation")
        view_experiment_page.check_text_displayed("Experiment Results")
        view_experiment_page.wait_till_text_displayed("This Experiment is complete. The results are available below.", 600)



    def tearDown(self):
        self.driver.close()