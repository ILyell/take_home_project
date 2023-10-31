require 'rails_helper'

describe "Subscriptions Request" do

    describe "Adds a subscription to a customer" do

        it "Returns 200 and Success when subscription added" do

            create(:customer)
            test_customer = Customer.first
            create(:tea)
            test_tea = Tea.first

            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                "data":{
                    "type": "subscription",
                    "attributes":{
                        "customer_id": test_customer.id,
                        "tea_id": test_tea.id,
                        "status": "active",
                        "title": "Earl Grey",
                        "price": 1.50,
                        "frequency": "Monthly"
                    }
                }
            }

            post '/api/v0/subscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(201)

            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Success!")
        end

        it "Returns 422 if request body is invalid" do
            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                        "customer_id": 2,
                        "tea_id": 3,
                        "status": "active",
                        "price": 1.50,
                        "frequency": "Monthly"
                    }

            post '/api/v0/subscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(422)

            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Invalid request")
            expect(response).to have_key(:errors)
        end

        it "Returns 404 if invalid flields / IDs" do

            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                "data":{
                    "type": "subscription",
                    "attributes":{
                        "customer_id": 1231231,
                        "tea_id": 1231,
                        "status": "active",
                        "title": "Earl Grey",
                        "price": 1.50,
                        "frequency": "Monthly"
                        }
                    }
                }

            post '/api/v0/subscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(404)
            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Validation Failed")
            expect(response).to have_key(:errors)
        end
    end

    describe  "Removes a subscription from a customer" do
        it "Returns 200 and success when subscription is removed" do

            create(:customer)
            test_customer = Customer.first
            create(:tea)
            test_tea = Tea.first

            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                "data":{
                    "type": "subscription",
                    "attributes":{
                        "customer_id": test_customer.id,
                        "tea_id": test_tea.id,
                        "status": "active",
                        "title": "Earl Grey",
                        "price": 1.50,
                        "frequency": "Monthly"
                        }
                    }
                }

            post '/api/v0/subscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(201)

            test_subscription = test_customer.subscriptions.first
            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                "data":{
                    "type": "subscription",
                    "attributes":{
                        "id": test_subscription.id,
                    }
                }
            }
            post '/api/v0/unsubscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(200)
            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Success!")
        end

        it "Returns 422 if request body is invalid" do
            headers = {"CONTENT_TYPE" => "application/json"}

            request_body =  {
                "data": {
                "id": 126
                }
            }

            post '/api/v0/unsubscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(422)
            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Invalid request")
            expect(response).to have_key(:errors)
        end

        it "Returns 404 if invalid flields / ID" do
            headers = {"CONTENT_TYPE" => "application/json"}
            request_body =  { 
                "data":{
                    "type": "subscription",
                    "attributes":{
                        "id": 1122,
                    }
                }
            }
            post '/api/v0/unsubscribe', headers: headers, params: JSON.generate(request_body)

            expect(response.status).to eq(404)
            response_body = response.body
            response = JSON.parse(response_body, symbolize_names: true)

            expect(response).to have_key(:message)
            expect(response[:message]).to eq("Subscription not found")
            expect(response).to have_key(:errors)

        end
    end
end