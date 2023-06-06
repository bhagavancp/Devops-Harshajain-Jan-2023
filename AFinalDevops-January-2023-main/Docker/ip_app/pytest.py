import unittest, json
from main import app

class TestApp(unittest.TestCase):
    
    # test case to check if the root URL returns a valid IP address
    def test_get_ip(self):
        tester = app.test_client(self)
        response = tester.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertNotEqual(response.data.decode('utf-8'), '')
    
    # test case to check if the "/health" endpoint returns a success message with status code 200
    def test_app_health(self):
        tester = app.test_client(self)
        response = tester.get('/health')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.data)['success'], True)

if __name__ == '__main__':
    unittest.main()
