require 'rails_helper'

RSpec.describe Cast, type: :model do
  describe "all_registerメソッド" do
    before do
      @releases = Release.create(year: 2022,season: "春")
      TestMethod::Work.create_sample_data(quantity: 20)
      works = Work.all
      @before_register_count = Cast.count
      Cast.all_register
    end
    context "一回目の実行時" do
      it "castテーブルのレコードが増えていること" do
        expect(@before_register_count === 0).to be_truthy
        expect(Cast.count > @before_register_count).to be_truthy
      end
    end
    context "二回目の実行時" do
      before do 
        @before_register_count2 = Cast.count
        Cast.all_register
      end
      it "castテーブルのレコードの数が変わらないこと" do
        expect(@before_register_count < @before_register_count2).to be_truthy
        expect(Cast.count === @before_register_count2).to be_truthy 
      end
      it "castテーブルに作成されたデータに重複がないこと" do
        first_cast = Cast.first
        expect(Cast.where(character: first_cast.character,cast: first_cast.cast).count === 1).to be_truthy
      end
    end
  end
end
