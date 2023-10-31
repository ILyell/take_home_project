class Api::V0::TeasController < ApplicationController

    def index
        render json: TeaSerializer.new(Tea.all)
    end
end