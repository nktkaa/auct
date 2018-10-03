class ApplicationController < ActionController::Base
  #include ActionController::Cookies

  before_action :authenticate_user!, :set_currency
  protect_from_forgery with: :exception

  def set_currency
    cookies[:currency_id] ||= Currency.codes.values.first
  end

  helper_method :current_users_item?
  def current_users_item?(item)
    item.user.id == current_user.id
  end

  helper_method :current_currency
  def current_currency
    Currency.find_or_create_by(code: cookies[:currency_id].to_i)
  end

end
