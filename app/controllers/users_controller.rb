class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(user_params)
      flash[:success] = "プロフィールが更新されました！"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "更新に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_to root_path
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  
  private

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction)
  end

end

