# Take home README

This is a rails take home project from Turing. This readme will walk through getting this repo running locally, endpoint usuage, and some metric data.

## Installing this repository
### Version Info
  - Ruby 3.2.2
  - Rails 7.0.8
### Running the repo  
  - Clone and fork this repo
  - Run ```bundle install``` 
  - Run ```rails db:{drop,create,migrate}``` to setup the postgresQL database. You can also run the ```rails db:seed``` command after if you would like to have mock data seeded into the database.
  - Run ```bundle exec rspec``` to run the full test suite. There should be 20 test passing with 100% simplecov coverage.
###  Schema
  ![Screenshot 2023-11-02 at 2 46 14 PM](https://github.com/ILyell/take_home_project/assets/127703036/b974b548-9051-43b9-bb21-72e4377b5dc0)


## Endpoint Usage

### GET api/v0/teas
  Returns a list of all teas in the database

  Example: ```http://localhost:3000/api/v0/teas```

  Response:
  ```json
  {
    "data": [
        {
            "id": "1",
            "type": "tea",
            "attributes": {
                "title": "English Afternoon",
                "description": "Herbal",
                "temperature": 68.4,
                "brew_time": "0.87"
            }
        },{
            "id": "2",
            "type": "tea",
            "attributes": {
                "title": "Gongmei",
                "description": "Green",
                "temperature": 32.6,
                "brew_time": "9.74"
            }
        },{
            "id": "100",
            "type": "tea",
            "attributes": {
                "title": "Rize",
                "description": "Green",
                "temperature": 71.6,
                "brew_time": "2.66"
            }
        }
    ]
}
```

### GET api/v0/teas/:id
  Returns a single tea from the id.
  
  Example: ```http://localhost:3000/api/v0/teas/12```
  
  Response:
  ```json
{
    "data": {
        "id": "12",
        "type": "tea",
        "attributes": {
            "title": "Hibiscus",
            "description": "Oolong",
            "temperature": 36.4,
            "brew_time": "5.21"
        }
    }
}
```

### POST api/v0/customer
  Returns a customer with thier info, and all thier subscriptions

  Example: ```http://localhost:3000/api/v0/customer```

  Request: 
  ```json
{ 
"data":{
    "type": "customer",
    "attributes":{
        "id": 1
        }
    }
}
```
  Response:
  ```json
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": "Leon",
            "last_name": "Becker",
            "email": "greg_ward@roob.example",
            "address": "39211 Funk Fort, Manteborough, WV 77697",
            "subscriptions": [
                {
                    "id": 2,
                    "tea_id": 4,
                    "customer_id": 1,
                    "title": "Earl Grey",
                    "price": 1.5,
                    "status": "active",
                    "frequency": "Monthly",
                    "created_at": "2023-11-01T16:33:31.855Z",
                    "updated_at": "2023-11-01T16:33:31.855Z"
                }
            ]
        }
    }
}
```
### POST api/v0/subscribe
  Subscribes a customer to a tea

  Example: ```http://localhost:3000/api/v0/subscribe```

  Request:
  ```json
{ 
"data":{
    "type": "subscription",
    "attributes":{
        "customer_id": 1,
        "tea_id": 4,
        "status": "active",
        "title": "Earl Grey",
        "price": 1.50,
        "frequency": "Monthly"
        }
    }
}
```

Response: 
```json
{
    "message": "Success!"
}
```

### POST api/v0/unsubscribe

Example: ```http://localhost:3000/api/v0/unsubscribe```

Request: 
```json
{ 
"data":{
    "type": "subscription",
    "attributes":{
        "customer_id": 1,
        "tea_id": 1
        }
    }
}
```
Response: 
```json
{
    "message": "Success!"
}
```
  
## Endpoint Testing with Locust
  Included below are charts that were made utilizing Locust testing to swarm the endpoints in given ratios and task sets. Each test was run with 250 simulated users for 10 minutes. The server was hosted on Heroku with the basic dyno and the basic postgresql settings. The database was then pre-seeded with faker and factorybot to create 10k teas 2k users and 200k+ subscriptions. The testing script is included at ```metrics/locustfile.py``` and all saved data is in ```metrics/results```

### Base User testing with no weighting. 
![image](https://github.com/ILyell/take_home_project/assets/127703036/5dffa06b-4100-493f-96d2-eeb477d50e21)
![image](https://github.com/ILyell/take_home_project/assets/127703036/2e730918-72ef-4b3e-9b9a-dbb375f052aa)

### Add weighting to single user
![image](https://github.com/ILyell/take_home_project/assets/127703036/3ef3e732-c9ba-4ee5-83c1-e73ab960ab54)
![image](https://github.com/ILyell/take_home_project/assets/127703036/6a34152f-6aaa-4f55-a2e3-a6b8979788c9)

### Add second lurker user that is 75% of the user base
![image](https://github.com/ILyell/take_home_project/assets/127703036/5b41060e-a0a3-4ef8-bc7f-58834d383a13)
![image](https://github.com/ILyell/take_home_project/assets/127703036/6bbb3d1a-dd26-4f99-806e-0e42ea0e450b)
