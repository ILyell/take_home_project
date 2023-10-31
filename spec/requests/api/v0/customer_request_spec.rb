require 'rails_helper'

describe "Customer API" do
    it "sends subscrption info for a customer" do
        create(:customer, name: "Ian")

        headers = {"CONTENT_TYPE" => "application/json"}
        body =  {"id": 0} 
        post '/api/v0/customer', headers: headers, body: body

        expect(response).to be_successful
    end
end