class League < ApplicationRecord
  belongs_to :tournament
  has_many :groups, dependent: :destroy
end
