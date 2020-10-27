require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:plans) }
  end

  describe "Enums" do
    it { should define_enum_for(:delete_flag) }
  end

  describe "Scopes" do
    before do
      @first_category = FactoryBot.create :category
      @second_category = FactoryBot.create :category
    end

    it "orders by created_at" do
      expect(Category.newest).to match_array [@second_category, @first_category]
    end
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end
end
