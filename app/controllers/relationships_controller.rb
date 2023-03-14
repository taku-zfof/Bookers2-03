class RelationshipsController < ApplicationController
before_action :authenticate_user!

  def create
    current_user.follow_suru.create(follow_sareru_id: params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    re=current_user.follow_suru.find_by(follow_sareru_id: params[:user_id])
    re.destroy
    redirect_to request.referer
  end

end
