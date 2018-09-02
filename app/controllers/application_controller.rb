require "application_responder"
class ApplicationController < ActionController::Base
  before_action :set_locale

  self.responder = ApplicationResponder
  respond_to :html, :js

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
