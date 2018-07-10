require 'rails_helper'

RSpec.describe TournamentParticipant, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to belong_to(:participant) }
    it { is_expected.to respond_to(:seeding) }
  end
end
