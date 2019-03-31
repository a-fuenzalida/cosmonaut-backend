class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    include DeviseTokenAuth::Concerns::SetUserByToken
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    private
        def record_not_found(error)
            render json: { error: error.message }, status: :not_found
        end

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :name, :email, :image, :password])
            devise_parameter_sanitizer.permit(:sign_in, keys: [:nickname, :email, :password])
            devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :name, :email, :image, :password, :information, :private])
        end
end