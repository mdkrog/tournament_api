require 'rails_helper'

RSpec.describe LadderPosition, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:participant) }
    it { is_expected.to respond_to(:position) }
    it { is_expected.to respond_to(:points) }
  end
end
