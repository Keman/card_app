class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      flash[:success] = t "oauth.success", provider: provider.titleize
      redirect_to root_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        flash[:success] = t "oauth.success", provider: provider.titleize
        redirect_to root_path
      rescue
        flash[:danger] = t "oauth.danger", provider: provider.titleize
        redirect_to root_path
      end
    end
  end

  private

  def auth_params
    params.permit(:provider, :oauth_token, :oauth_verifier)
  end
end
