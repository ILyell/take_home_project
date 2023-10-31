require 'rails_helper'

describe "Customer API" do
    describe "Send customer info" do
        it "returns all customer info and subscriptions" do

            create(:customer)
            test_customer = Customer.first

            headers = {"CONTENT_TYPE" => "application/json"}
            body =  { 
                "data":{
                    "type": "customer",
                    "attributes":{
                        "id": test_customer.id
                        }
                    }
                }

            post '/api/v0/customer', headers: headers, params: JSON.generate(body)

            expect(response.status).to eq(200)

            customer = JSON.parse(response.body, symbolize_names: true)

            expect(customer).to have_key(:data)
            expect(customer[:data]).to have_key(:type)
            expect(customer[:data][:type]).to eq("customer")
            expect(customer[:data]).to have_key(:id)
            expect(customer[:data][:id]).to eq(test_customer.id.to_s)
            
            expect(customer[:data]).to have_key(:attributes)
            expect(customer[:data][:attributes]).to have_key(:first_name)
            expect(customer[:data][:attributes][:first_name]).to eq(test_customer.first_name)
            expect(customer[:data][:attributes]).to have_key(:last_name)
            expect(customer[:data][:attributes][:last_name]).to eq(test_customer.last_name)
            expect(customer[:data][:attributes]).to have_key(:email)
            expect(customer[:data][:attributes][:email]).to eq(test_customer.email)
            expect(customer[:data][:attributes]).to have_key(:address)
            expect(customer[:data][:attributes][:address]).to eq(test_customer.address)
            expect(customer[:data][:attributes]).to have_key(:subscriptions)
            expect(customer[:data][:attributes][:subscriptions]).to eq([])
        end

        it 'returns 404 if customer not found' do
            headers = {"CONTENT_TYPE" => "application/json"}
            body =  { 
                "data":{
                    "type": "customer",
                    "attributes":{
                        "id": 12133
                        }
                    }
                }

            post '/api/v0/customer', headers: headers, params: JSON.generate(body)

            expect(response.status).to eq(404)
            body = response.body
            response = JSON.parse(body, symbolize_names: true)
            
            expect(response[:message]).to eq("Customer not found")
        end

        it 'returns 422 if request body is invalid' do
            headers = {"CONTENT_TYPE" => "application/json"}
            body =  { 
                    "type": "customer",
                    "id": 12133
                }

            post '/api/v0/customer', headers: headers, params: JSON.generate(body)

            expect(response.status).to eq(422)
            body = response.body
            response = JSON.parse(body, symbolize_names: true)
            
            expect(response[:message]).to eq("Invalid request format")
        end
    end
end