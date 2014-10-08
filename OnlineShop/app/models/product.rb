class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true }

  has_attached_file :image,
  :styles => {
    :thumb => "100x100#",
    :small  => "150x150>",
    :medium => "200x200" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method:
  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }

  scope :available, -> { where(quantity: '> 0') }
end
