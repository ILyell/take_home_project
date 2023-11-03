from locust import HttpUser, task, between
import random
from faker import Faker
    

class MyUser(HttpUser):
    weight = 1
    host = "https://turing-take-home-bc328e948954.herokuapp.com/api/v0"
    wait_time = between(1, 5)  # Time between consecutive requests
    def on_start(self):
        self.faker = Faker()
        self.customer_id = random.randint(1, 2000)
        self.set_tea_id = None

    @task       
    def GetCustomer(self):
        endpoint = "/customer"

        payload = {
                    "data": {
                        "type": "customer",
                        "attributes": {
                            "id": self.customer_id,
                        }
                    }
                }

        headers = {
            "Content-Type": "application/json"
        }

        with self.client.post(endpoint, json=payload, headers=headers, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")


    @task(3)
    def GetAllTeas(self):

        endpoint = "/teas"

        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")


    @task(4)
    def GetATea(self):
        tea_id = random.randint(1,10000)


        endpoint = f"/teas/{tea_id}"

        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")


    @task(4)
    def Subscribe(self):
        endpoint = "/subscribe"
        self.set_tea_id = random.randint(1,10000)
        status = ["pending", "active", "inactive"]
        payload = {
            "data": {
                "type": "subscription",
                "attributes": {
                    "customer_id": self.customer_id,
                    "tea_id": self.set_tea_id,
                    "status": status[random.randint(0,2)],
                    "title": "Earl Grey",
                    "price": self.faker.pricetag(),
                    "frequency": "Monthly"
                }
            }
        }

        headers = {
            "Content-Type": "application/json"
        }

        with self.client.post(endpoint, json=payload, headers=headers, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")


    @task(2)
    def Unsubcribe(self):
        endpoint = "/unsubscribe"
        
        if self.set_tea_id == None:
            self.Subscribe()
        
        payload = {
            "data": {
                "type": "subscription",
                "attributes": {
                    "customer_id": self.customer_id,
                    "tea_id": self.set_tea_id
                }
            }
        }

        headers = {
            "Content-Type": "application/json"
        }

        with self.client.post(endpoint, json=payload, headers=headers, catch_response=True) as response:
            if response.status_code == 200:
                self.set_tea_id = None
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")

class LurkerUser(HttpUser):
    host = "https://turing-take-home-bc328e948954.herokuapp.com/api/v0"
    wait_time = between(1, 5)  
    weight = 3

    @task
    def GetATea(self):
        tea_id = random.randint(1,10000)


        endpoint = f"/teas/{tea_id}"

        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")


    @task
    def GetAllTeas(self):

        endpoint = "/teas"

        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.elapsed.total_seconds() > 1.0:
                response.failure(f"Request took too long: {response.elapsed.total_seconds()} seconds")
