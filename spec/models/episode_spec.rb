require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe "limit_registerメソッド" do
    before do 
      Release.create(year: 2022, season: "春")
      TestMethod::Work.create_sample_data(quantity: 50)
    end
    context "countの引数に10を与えた場合" do
      it "エピソードが存在する10作品のエピソードが登録されていること" do
        TestMethod::Episode.limit_register(10)
        @first_work = Work.first
        @tenth_work = Work.limit(10).last
        expect(@first_work.annict_id === Episode.first.work_id).to be_truthy
        expect(@tenth_work.annict_id === Episode.last.work_id).to be_truthy
      end
    end
    context "countの引数に20を与えた場合" do
      it "エピソードが存在する20個の作品のエピソードが登録されていること" do
        TestMethod::Episode.limit_register(20)
        @first_work = Work.first
        @twentieth_work = Work.limit(20).last
        expect(@first_work.annict_id === Episode.first.work_id).to be_truthy
        expect(@twentieth_work.annict_id === Episode.last.work_id).to be_truthy
      end
    end
    context "countの引数に30を与えた場合" do
      it "エピソードが存在する" do
        TestMethod::Episode.limit_register(30)
        @first_work = Work.first
        @thirtieth_work = Work.limit(30).last
        expect(@first_work.annict_id === Episode.first.work_id).to be_truthy
        expect(@thirtieth_work.annict_id === Episode.last.work_id).to be_truthy
      end
    end
  end
  describe "all_registerメソッド" do
    before do
      Release.create(year: 2022, season: "春")
      TestMethod::Work.create_sample_data(quantity: 20)
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
