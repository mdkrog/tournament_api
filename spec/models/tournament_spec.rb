require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe "fields and validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:format) }
    it { is_expected.to have_many(:participants).through(:tournament_participants) }
    it { is_expected.to have_many(:leagues) }
  end
end