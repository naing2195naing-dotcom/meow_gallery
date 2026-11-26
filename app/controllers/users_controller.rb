
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user),
                  notice: "プロフィールを更新しました。",
                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    terminate_session
    redirect_to root_path,
                notice: "アカウントを削除しました。",
                status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    unless @user == Current.user
      redirect_to user_path(Current.user),
                  alert: "他のユーザーの情報は編集できません。",
                  status: :see_other
    end
  end

  def user_params
    params.require(:user).permit(:name, :email_address, :profile_image)
  end
end
