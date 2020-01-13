require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:photo) { FactoryBot.create(:photo) }
  it '有効なファクトリを持つこと' do
    expect(photo).to be_valid
  end
end
