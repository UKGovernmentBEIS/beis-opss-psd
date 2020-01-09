class ApplicationController < ActionController::Base
  include AuthenticationConcern
  include CacheConcern
  include HttpAuthConcern
  include RavenConfigurationConcern

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_raven_context
  before_action :authorize_user
  before_action :has_accepted_declaration
  before_action :set_cache_headers

  helper_method :nav_items, :secondary_nav_items, :previous_search_params, :current_user

  def authorize_user
    raise Pundit::NotAuthorizedError unless User.current&.is_psd_user?
  end

  def has_accepted_declaration
    redirect_to declaration_index_path(redirect_path: request.original_fullpath) unless User.current.has_accepted_declaration
  end

  def hide_nav?
    false
  end

  def nav_items
    return nil if hide_nav? || !User.current # On some pages we don't want to show the main navigation

    items = []
    unless User.current.is_opss?
      items.push text: "Home", href: root_path, active: params[:controller] == "homepage"
    end
    items.push text: "Cases", href: investigations_path(previous_search_params), active: params[:controller].start_with?("investigations")
    items.push text: "Businesses", href: businesses_path, active: params[:controller].start_with?("businesses")
    items.push text: "Products", href: products_path, active: params[:controller].start_with?("products")
    # In principle all our users belong to a team, but this saves crashes in case of a misconfiguration
    if User.current.teams.present?
      text = User.current.teams.count > 1 ? "Your teams" : "Your team"
      path = User.current.teams.count > 1 ? your_teams_path : team_path(User.current.teams.first)
      items.push text: text, href: path, active: params[:controller].start_with?("teams"), right: true
    end
    items
  end

  def previous_search_params
    # No clear way to only replace search params, as they are seperate from each other and not easily identifiable.
    # This list will have to be updated when new search filters are added.
    if session[:previous_search_params].present?
      s = session[:previous_search_params]
      {
        assigned_to_me: s[:assigned_to_me],
        assigned_to_someone_else: s[:assigned_to_someone_else],
        assigned_to_someone_else_id: s[:assigned_to_someone_else_id],
        assigned_to_team_0: s[:assigned_to_team_0],
        created_by_me: s[:created_by_me],
        created_by_someone_else: s[:created_by_someone_else],
        created_by_someone_else_id: s[:created_by_someone_else_id],
        created_by_team_0: s[:created_by_team_0],
        allegation: s[:allegation],
        enquiry: s[:enquiry],
        project: s[:project],
        status_open: s[:status_open],
        status_closed: s[:status_closed]
      }
    else
      {}
    end
  end

  def secondary_nav_items
    items = []
    if User.current
      items.push text: "Your account", href: KeycloakClient.instance.user_account_url
      items.push text: "Sign out", href: logout_session_path
    else
      items.push text: "Sign in", href: keycloak_login_url
    end
    items
  end
end
