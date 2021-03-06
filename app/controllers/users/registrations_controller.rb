# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :forbid_guest_user, {only: [:edit, :update, :destroy]}

  def new
    super
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー認証メールを送信いたしました。認証が完了しましたらログインをお願いいたします。"
      redirect_to new_user_session_path
    else
      flash[:alert] = "ユーザー登録に失敗しました。"
      render action: :new and return
    end
  end

  protected
    # アカウント編集後、プロフィール画面に移動する
    def after_update_path_for(resource)
      user_path(id: current_user.id)
    end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def forbid_guest_user
      if @user.email == "guest@example.com"
        flash[:alert] = "ゲストユーザーの編集・退会はできません。"
        redirect_to root_path
      end
    end

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end
end
