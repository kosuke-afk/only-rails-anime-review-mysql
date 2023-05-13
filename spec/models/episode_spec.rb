require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe "all_registerメソッド" do
    before do
      Release.create(year: 2022, season: "春")
      Work.create_sample_data(quantity: 20)
      expect(Episode.count === 0).to be_truthy
      Episode.all_register
    end
    context "一回目実行時" do
      it "エピソードのレコードの数が増えている" do
        expect(Episode.count > 0 ).to be_truthy
      end
    end
    context "二回目以降実行時" do
      it "エピソードのレコードの数が変わらない" do
        previous_count = Episode.count
        Episode.all_register
        expect(Episode.count === previous_count).to be_truthy
      end
    end
  end
end
