class Banner < ActiveRecord::Base
  mount_uploader :image , ImageUploader
end
