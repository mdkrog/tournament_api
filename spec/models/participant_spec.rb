require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "fields and validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
