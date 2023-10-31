require 'rails_helper'

describe "Tea Request" do
    it "sends a list of all tea" do

        create_list(:tea, 10)
        test_tea = Tea.first

        get api_v0_teas_path
        expect(response).to be_successful

        response = JSON.parse(response, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data].count).to eq(10)
    end
end