class RelationshipsController < ApplicationController
  before_action :user_signed_in?

  def create
    @user = User.find_by(params[:followed_id]) # 対象ユーザーを受け取る
    current_user.follow(@user) # 対象ユーザーをフォローする
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed # Relationshipからidを取得
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
