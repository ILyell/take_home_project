class Api::V0::SubscriptionsController < ApplicationController
    
    def subscribe
        subscription = subscription_params[:attributes]
        Subscription.create!(subscription)
        render json: {data: {message: "Success!"}},  status: :created
    end

    def unsubscribe
        Subscription.delete(subscription_params[:attributes][:id])
        render json: {data: {message: "Success!"}}
    end



    private

    def subscription_params
        params.require(:data).permit(
            :type, 
            attributes: [:customer_id, :tea_id, :title, :price, :status, :frequency, :id]
        )
    end
end