class Pin < ActiveRecord::Base
	has_attachment  :image, accept: [:jpg, :jpeg, :png, :gif]
	validates :image, presence: true
 # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	belongs_to :user
end
