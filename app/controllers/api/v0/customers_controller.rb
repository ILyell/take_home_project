class Api::V0::CustomersController < ApplicationController

    def show
        customer = Customer.find(customer_params[:attributes][:id])
        render json: CustomerSerializer.new(customer)
    rescue ActionController::ParameterMissing, NoMethodError => e
        render json: { message: "Invalid request", errors: e }, status: 422
    rescue ActiveRecord::RecordNotFound => e
        render json: { message: "Customer not found", errors: e }, status: 404
    end

    private

    def customer_params
        params.require(:data).permit(:type, attributes:[:id])
    end
end