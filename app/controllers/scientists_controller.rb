class ScientistsController < ApplicationController

    def index
        render json: Scientist.all, status: :ok
    end

    def show
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistPostSerializer, status: :ok
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Scientist not found"}, status: 404
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: 201
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy
        render json: {}
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Scientist not found"}, status: 404
    end

    def update
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: 202
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Scientist not found"}, status: 404
    end

    private
    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end


end
