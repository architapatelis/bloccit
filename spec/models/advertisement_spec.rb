require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title: "New Ad Title", body: "New Ad Body", price: 99) }

  describe "attributes" do
    it "has title, body and price attributes" do
      expect(advertisement).to have_attributes(title: "New Ad Title", body: "New Ad Body", price: 99)
    end
  end
end
