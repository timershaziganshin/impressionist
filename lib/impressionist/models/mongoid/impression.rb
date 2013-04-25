class Impression
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :impressionable_type, :impressionable_field, :impressionable_id, :user_id,
  :controller_name, :action_name, :view_name, :request_hash, :ip_address,
  :session_hash, :message, :referrer

  embedded_in :impressionable, polymorphic: true

  field :user_id
  field :controller_name
  field :action_name
  field :view_name
  field :request_hash
  field :ip_address
  field :session_hash
  field :message
  field :referrer

  set_callback(:create, :after) do |doc|
    if self.impressionable.class.impressionist_counter_cache_options
      self.impressionable.try(:update_impressionist_counter_cache)
    end
  end

end
