class Api::V0::CustomersController < ApplicationController

    def show
        customer = Customer.find(params[:data][:attributes][:id])
        render json: CustomerSerializer.new(customer)
    rescue NoMethodError
        render json: {message:"Invalid request format"}, status: 422
    rescue ActiveRecord::RecordNotFound
        render json: {message:"Customer not found"}, status: :not_found
    end
end