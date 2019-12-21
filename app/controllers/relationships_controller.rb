class RelationshipsController < ApplicationController
  before_aciton :set_user

  def create
    following = current_user.follow(user)
    if following.save
      flash[:succese] = 'フォローしました'
      redirect_to user
    else
      flash.now[:alert] = 'フォローに失敗しました'
      redirect_to user
    end
  end

  def destroy
    following = current_user.unfollow(user)
    if following.destroy
      flash[:succese] = 'フォローを解除しました'
      redirect_to user
    else
      flash.now[:alert] = 'フォローの解除に失敗しました'
      redirect_to user
    end
  end

  private

  def set_user
    user = User.find(params[:relationship][:follow_id])
  end
end
