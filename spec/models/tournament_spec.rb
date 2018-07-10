require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe "fields and validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:format) }
  end
end