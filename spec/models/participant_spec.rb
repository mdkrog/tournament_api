require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "fields and validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:tournaments).through(:tournament_participants) }
  end
end
