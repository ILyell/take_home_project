class Api::V0::CustomersController < ApplicationController

    def show
        customer = Customer.find(params[:data][:attributes][:id])
        render json: CustomerSerializer.new(customer)
    end
end