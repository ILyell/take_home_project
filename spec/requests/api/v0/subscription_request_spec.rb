require 'rails_helper'

describe "Subscriptions Request" do
    it "Adds a subscription to a customer" do

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

        expect(response).to have_key(:data)
        expect(response[:data]).to have_key(:message)
        expect(response[:data][:message]).to eq("Success!")
    end
    it "Removes a subscription from a customer" do

        create(:customer)
        test_customer = Customer.first
        create(:tea)
        test_tea = Tea.first
        # Send subscribe request
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

        # Send unsubscribe request
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

        expect(response).to have_key(:data)
        expect(response[:data]).to have_key(:message)
        expect(response[:data][:message]).to eq("Success!")
    end
end