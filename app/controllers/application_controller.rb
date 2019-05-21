class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  
  $WEEKS = %w{日 月 火 水 木 金 土}
end
