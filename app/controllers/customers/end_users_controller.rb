class Customers::EndUsersController < ApplicationController

  def update
  	current_end_user.update(end_user_params)
  	redirect_to end_user_path(current_end_user)
  end

  def confirm
  end

  private
  def end_user_params
  	params.require(:end_user).permit(:first_name, :last_name, :first_kana_name, :last_kana_name, :postcode, :address, :phone_number)
  end
end



