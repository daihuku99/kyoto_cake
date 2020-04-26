class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters,if: :devise_controller?

	def after_sign_in_path_for(resource_or_scope)
		if resource_or_scope.class == Admin
			admins_root_path
		elsif resource_or_scope.class == EndUser
			root_path
		else
		end
	end

	def after_sign_out_path_for(resource_or_scope)
		if resource_or_scope == :user
			new_admins_user_session_path
		elsif resource_or_scope == :end_user
			items_path
		else
		end
	end

	# def set_tax
	# 	@tax = 1.1
	# end
	

	private
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_kana_name, :last_kana_name, :email, :postcode, :address, :phone_number])
	end
end
