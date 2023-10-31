require 'rails_helper'

describe "Tea Request" do
    it "sends a list of all tea" do

        create_list(:tea, 10)
        test_tea = Tea.first
        headers = {"CONTENT_TYPE" => "application/json"}

        get api_v0_teas_path, headers: headers
        expect(response.status).to eq(200)
        response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data].count).to eq(10)
    end

    it "Can send info of a single tea" do

        create_list(:tea, 10)
        test_tea = Tea.first

        get api_v0_tea_path(test_tea)

        expect(response.status).to eq(200)
        response = JSON.parse(response.body, symbolize_names: true)

    end
end