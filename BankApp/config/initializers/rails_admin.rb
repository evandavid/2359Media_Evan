RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
   RailsAdmin.config do |config|
    config.authorize_with do
      authenticate_or_request_with_http_basic('Site Message') do |username, password|
        username == 'admin' && password == 'admin'
      end
    end

    # config.model Product do
    #   edit do
    #     # For RailsAdmin >= 0.5.0
    #     field :name
    #     field :description, :wysihtml5
    #     field :price, :integer
    #     field :quantity, :integer
    #     field :image, :paperclip
    #   end
    # end

    # config.model Coupon do
    #   edit do
    #     # For RailsAdmin >= 0.5.0
    #     field :product
    #     field :coupon, :integer
    #     field :is_active, :boolean
    #   end
    # end
  end

  config.included_models = ["Transaction", 'User']
  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
