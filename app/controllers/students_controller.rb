class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        students = Student.all
        render json: students, status: 200
    end
    
    def show
        student = Student.find(params[:id])
        render json: student, status: 200
    end

    def update 
        student = Student.find(params[:id])
        if student
            updated_student = student.update!(permited_params)
            render json: updated_student
        end
    end

    private

    def permited_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def record_not_found
        render json: { "errors": "Not Found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
