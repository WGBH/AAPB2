class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.new(request)
  end

  # def default_url_options
  #   if Rails.env.production?
  #     {:host => "americanarchive.org"}
  #   else  
  #     {host: 'localhost:8080'}
  #   end
  # end

  def search_action_url
    # override blacklight url helper because docker container doesnt know what localhost port the browser needs in development, by default gives no port
    dupe_options = url_options.deep_dup
    dupe_options[:port] = '3000' unless Rails.env.production?
    catalog_index_url(dupe_options)
  end
end
