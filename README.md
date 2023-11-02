# Take home README

This is a rails take home project from Turing. This readme will walk through getting this repo running locally, endpoint usuage, and some metric data.

## Installing this repository
### Version Info
  - Ruby 3.2.2
  - Rails 7.0.8
### Running the repo  
  - Clone and fork this repo
  - Run ```bundle install``` 
  - Run ```rails db:{drop,create,migrate}``` to setup the postgresQL database. You can also run the ```seed``` command after if you would like to have mock data seeded into the database.
  - Run ```bundle exec rspec``` to run the full test suite. There should be 20 test passing with 100% simplecov coverage.

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

  
