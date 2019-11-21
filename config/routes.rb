Rails.application.routes.draw do
  root to: 'home#show'

  blacklight_for :catalog

  resources 'terms',
            only: [:show, :create]

  resources 'embed', only: [:index, :show] # BL requires that there be an index.
  resources 'embed_terms', only: [:show, :create]

  resources 'organizations',
            path: '/participating-orgs', # for backwards compatibility.
            constraints: { id: /.*/ }, # so periods in station IDs are acceptable.
            only: [:index, :show]

  resources 'advanced',
            only: [:index, :create]

  resources 'thumbnails',
            only: [:show]

  resources 'media',
            only: [:show]

  resources 'captions',
            only: [:show]

  resources 'transcripts',
            only: [:show]

  resources 'oai',
            only: [:index]

  match 'api', to: 'api#index', via: [:get, :options]
  match 'api/:id', to: 'api#show', via: [:get, :options]
  match 'api/:id/transcript', to: 'api#transcript', via: [:get, :options], defaults: { format: :json }
  # 'via' only makes a difference when server is in production or test modes.

  %w(404 500).each do |status_code|
    get status_code, to: 'errors#show', status_code: status_code
  end

  get 'robots', to: 'robots#show'

  override_constraints = lambda do |req|
    path = req.params['path']
    path.match(/^[a-z0-9\/-]+$/) && !path.match(/^rails/)
  end

  # TODO: combine these into a resource?
  get '/exhibits', to: 'exhibits#index'
  get '/exhibits/*path', to: 'exhibits#show', constraints: override_constraints
  get '/special_collections', to: 'special_collections#index'
  get '/special_collections/*path', to: 'special_collections#show', constraints: override_constraints
  get '/webinars', to: 'webinars#index'
  get '/webinars/*path', to: 'webinars#show', constraints: override_constraints
  get '/plain_override/*path', to: 'plain_override#show', constraints: override_constraints
  get '/topical_resources', to: 'topical_resources#index'

  # NET Catalog is now a SpecialCollection, so redirecting there.
  # This need to be above the '/*path' route below, otherwise it won't work.
  net_catalog_constraint = lambda do |req|
    req.params['path'].start_with?('about-the-american-archive/projects/net-catalog')
  end
  get '/*path', to: redirect('/special_collections/net-catalog', status: 301), constraints: net_catalog_constraint

  get '/*path', to: 'override#show', constraints: override_constraints
end
