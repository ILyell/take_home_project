class Api::V0::SubscriptionsController < ApplicationController
    
    def subscribe
        Subscription.create!(subscription_params[:attributes])
        render json: { message: "Success!" },  status: :created
    rescue ActionController::ParameterMissing, NoMethodError => e
        render json: { message: "Invalid request", errors: e }, status: 422
    rescue ActiveRecord::RecordInvalid => e
        render json: { message: "Validation Failed", errors: e }, status: :not_found
    end

    def unsubscribe
        subscription = Subscription.find_by!(customer_id: subscription_params[:attributes][:customer_id], tea_id: subscription_params[:attributes][:tea_id])
        Subscription.delete(subscription)
        render json: { message: "Success!" }, status: 200
    rescue ActionController::ParameterMissing, NoMethodError => e
        render json: { message: "Invalid request", errors: e }, status: 422
    rescue ActiveRecord::RecordNotFound => e
        render json: { message: "Subscription not found", errors: e }, status: :not_found
    end

    private

    def subscription_params
        params.require(:data).permit(
            :type, 
            attributes: [:customer_id, :tea_id, :title, :price, :status, :frequency]
        )
    end
end