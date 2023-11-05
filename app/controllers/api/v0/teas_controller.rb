class Api::V0::TeasController < ApplicationController

    def index
        render json: TeaSerializer.new(Tea.all)
    end

    def show
        render json: TeaSerializer.new(Tea.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => e
        render json: { message: "Tea not found", errors: e}, status: 410
    end
end