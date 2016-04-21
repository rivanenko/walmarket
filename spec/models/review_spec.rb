require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it 'validates with a nil customer' do
      expect(FactoryGirl.build(:review, customer: nil)).to be_valid
    end

    it 'does not validate with a nil title' do
      expect(FactoryGirl.build(:review, title: nil)).not_to be_valid
    end

    it 'does not validate with a nil description' do
      expect(FactoryGirl.build(:review, description: nil)).not_to be_valid
    end

    context 'rating' do
      it 'does not validate when no rating is specified' do
        expect(FactoryGirl.build(:review, rating: nil)).not_to be_valid
      end

      it 'does not validate when the rating is not a number' do
        expect(FactoryGirl.build(:review, rating: 'not_a_number')).not_to be_valid
      end

      it 'does not validate when the rating is a float' do
        expect(FactoryGirl.build(:review, rating: 2.718)).not_to be_valid
      end

      it 'does not validate when the rating is less than 1' do
        expect(FactoryGirl.build(:review, rating: 0)).not_to be_valid
        expect(FactoryGirl.build(:review, rating: -5)).not_to be_valid
      end

      it 'does not validate when the rating is greater than 5' do
        expect(FactoryGirl.build(:review, rating: 6)).not_to be_valid
        expect(FactoryGirl.build(:review, rating: 8)).not_to be_valid
      end

      (1..5).each do |i|
        it "validates when the rating is #{i}" do
          expect(FactoryGirl.build(:review, rating: i)).to be_valid
        end
      end
    end
  end

  context 'scopes' do
    context 'newest_to_oldest' do
      let!(:review_1) { FactoryGirl.create(:review, created_at: 10.days.ago) }
      let!(:review_2) { FactoryGirl.create(:review, created_at: 2.days.ago) }
      let!(:review_3) { FactoryGirl.create(:review, created_at: 5.days.ago) }

      it 'properly runs newest_to_oldest queries' do
        expect(described_class.newest_to_oldest.to_a).to eq([review_2, review_3, review_1])
      end
    end

    context 'high_to_low_rating' do
      let!(:review_1) { FactoryGirl.create(:review, rating: 5) }
      let!(:review_2) { FactoryGirl.create(:review, rating: 2) }
      let!(:review_3) { FactoryGirl.create(:review, rating: 3) }
      let!(:review_4) { FactoryGirl.create(:review, rating: 1) }

      it 'properly runs high_to_low_rating queries' do
        expect(described_class.high_to_low_rating.to_a).to eq([review_1, review_3, review_2, review_4])
      end
    end

  end

  context '#recalculate_product_rating' do
    let(:product) { FactoryGirl.create(:product) }
    let!(:review) { FactoryGirl.create(:review, product: product) }

    it 'updates the product average rating' do
      expect(review.product).to receive(:recalculate_rating)
      review.save!
    end
  end
end
