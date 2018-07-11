class LadderPosition < ApplicationRecord
  belongs_to :participant
  belongs_to :group

  validates :participant_id, uniqueness: { scope: :group_id }
end
