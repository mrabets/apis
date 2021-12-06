require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should validate_presence_of(:name) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
  end
end