require 'rails_helper'

RSpec.describe LeagueMatch, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:participant1) }
    it { is_expected.to belong_to(:participant2) }
    it { is_expected.to respond_to(:round) }
    it { is_expected.to respond_to(:score) }
    it { is_expected.to respond_to(:winner) }
  end
end