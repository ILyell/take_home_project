class Api::V0::TeasController < ApplicationController

    def index
        render json: TeaSerializer.new(Tea.all)
    end

    def show
        render json: TeaSerializer.new(Tea.find(params[:id]))
    end
end