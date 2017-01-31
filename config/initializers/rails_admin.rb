RailsAdmin.config do |config|





  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)


  config.model Banner do
    list do
      field :image, :carrierwave do
        delete_method :image_delete     # don't forget to whitelist if you use :attr_accessible
        cache_method :image_cache   
      end
      field :title
      field :description
    end
  end

config.model Picture do
    list do
      field :image, :carrierwave do
        delete_method :image_delete     # don't forget to whitelist if you use :attr_accessible
        cache_method :image_cache   
      end
      # field :title
      # field :description
    end
  end
  # config.model 'Banner' do
  #   edit do
  #     field :image, :carrierwave
  #   end
  # end
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

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
