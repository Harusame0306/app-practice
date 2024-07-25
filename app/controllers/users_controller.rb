class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create_or_update
    @user = User.find_or_initialize_by(id: params[:id])

    if @user.new_record?
      @user.assign_attributes(user_params)
      if @user.save
        redirect_to user_path(@user.id)
      else
        render :new
      end
    else
      if @user.update(user_params)
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :profile_image)
  end
end
