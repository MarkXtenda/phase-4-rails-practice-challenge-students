class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        instructors = Instructor.all
        render json: instructors, status: 200
    end
    
    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: 200
    end

    def update 
        instructor = Instructor.find(params[:id])
        if instructor
            updated_instructor = instructor.update!(permited_params)
            render json: instructor
        end
    end

    private

    def permited_params
        params.permit(:name)
    end

    def record_not_found
        render json: { "errors": "Not Found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
