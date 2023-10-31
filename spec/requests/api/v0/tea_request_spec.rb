require 'rails_helper'

describe "Tea Request" do
    before(:each) do
        create_list(:tea, 10)
        @test_tea = Tea.first

    end
    it "sends a list of all tea" do

        headers = {"CONTENT_TYPE" => "application/json"}

        get api_v0_teas_path, headers: headers
        body = response.body
        expect(response.status).to eq(200)
        teas = JSON.parse(body, symbolize_names: true)

        expect(teas).to have_key(:data)
        expect(teas[:data].count).to eq(10)
        expect(teas[:data][0]).to have_key(:attributes)
        expect(teas[:data][0][:attributes]).to have_key(:title)
        expect(teas[:data][0][:attributes][:title]).to eq(@test_tea.title)
        expect(teas[:data][0][:attributes]).to have_key(:description)
        expect(teas[:data][0][:attributes][:description]).to eq(@test_tea.description)
        expect(teas[:data][0][:attributes]).to have_key(:brew_time)
        expect(teas[:data][0][:attributes][:brew_time]).to eq(@test_tea.brew_time)
        expect(teas[:data][0][:attributes]).to have_key(:temperature)
        expect(teas[:data][0][:attributes][:temperature]).to eq(@test_tea.temperature)
    end

    it "Can send info of a single tea" do

        get api_v0_tea_path(@test_tea)
        body = response.body
        expect(response.status).to eq(200)
        tea = JSON.parse(body, symbolize_names: true)

        expect(tea).to have_key(:data)
        expect(tea[:data]).to have_key(:type)
        expect(tea[:data][:type]).to eq("tea")
        expect(tea[:data]).to have_key(:id)
        expect(tea[:data][:id]).to eq(@test_tea.id.to_s)
        
        expect(tea[:data]).to have_key(:attributes)
        expect(tea[:data][:attributes]).to have_key(:title)
        expect(tea[:data][:attributes][:title]).to eq(@test_tea.title)
        expect(tea[:data][:attributes]).to have_key(:description)
        expect(tea[:data][:attributes][:description]).to eq(@test_tea.description)
        expect(tea[:data][:attributes]).to have_key(:brew_time)
        expect(tea[:data][:attributes][:brew_time]).to eq(@test_tea.brew_time)
        expect(tea[:data][:attributes]).to have_key(:temperature)
        expect(tea[:data][:attributes][:temperature]).to eq(@test_tea.temperature)
    end
end