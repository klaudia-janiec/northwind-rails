class Region < ApplicationRecord
  has_many :territories

  validates :region_description, presence: true, length: { maximum: 50 }
end
