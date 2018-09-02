class Contributor < ApplicationRecord
  belongs_to :search
  validates :position, :username, presence: true
end
