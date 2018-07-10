require 'rails_helper'

RSpec.describe League, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to respond_to(:number_of_groups) }
  end  
end
