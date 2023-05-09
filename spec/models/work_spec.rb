require 'rails_helper'

RSpec.describe Work do
  let!(:release)  {Release.create(year: 2011, season: "春")}
  describe "check_dupplicate?メソッド" do
    context "データの重複がない" do
      let!(:work)  {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 3}}
      it "falseが返ってくる" do
        @work = Work.create(**work.merge({release_id: release.id}))
        expect(@work.check_duplication?).to be_falsey
      end
    end
    context "データの重複がある" do
      let!(:work1)  {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 4}}
      let!(:work2) {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 5}}
      it "trueが返ってくる" do
        Work.create(**work1.merge({release_id: release.id}))
        @dupplicate_work = Work.create(**work2.merge({release_id: release.id}))
        expect(@dupplicate_work.check_duplication?).to be_truthy
      end
    end
  end

  describe "create_or_updateメソッド" do
    let!(:work) {{"title" => "ヨスガのソラ","title_kana" => "よすがのそら","images" => {"recommended_url" => ""},"episode_count" => 12,"media" => "TV","id" => 4}}
    it "データが作成できていること" do
      expect(Work.first).to be_falsey
      @work = Work.create_or_update(work: work, release_id: release.id)
      expect(Work.first).to be_truthy
    end

    it "重複データを作成しないこと" do
      Work.create_or_update(work: work, release_id: release.id)
      @work = Work.create_or_update(work: work, release_id: release.id)
      expect(@work.check_duplication?).to be_falsey
    end
  end

  describe "register_annict_dataメソッド" do
    let(:seasons) {["春","夏","秋","冬"]}
    before do
      @sYear = 2011
      @eYear = 2012
      (@sYear..@eYear).each do |year|
        seasons.each do |season|
          Release.create(year: year,season: season)
        end
      end
      @releases = Release.all
      Work.register_annict_data(@releases)
    end
    context "1回目に実行された場合" do
      it "与えられた期間の作品が登録されていること" do
        first = Work.first.release
        last = Work.last.release
        expect((first.year === @sYear && first.season === "春") && (last.year === @eYear && last.season === "冬")).to be_truthy
      end
      it "登録されたデータの数とannictにあるデータの数が等しいこと" do
        seasons = ["spring","summer","autumn","winter"]
        total_count = 0
        (@sYear..@eYear).each do |year|
          seasons.each do |season|
            total_count += Annict::Work.fetch_all_works(year: year,season: season)["total_count"]
          end
        end
        expect(Work.count === total_count).to be_truthy
      end
    end
    context "2回目以降実行した場合" do
      context "与えられた期間が同じ場合" do
        it "データの数が実行前と実行後で変わらないこと" do
          previous = Work.count
          Work.register_annict_data(@releases)
          expect(Work.count === previous).to be_truthy
        end
      end
      context "与えられた期間が異なる場合" do
        let!(:previous_count) {Work.count}
        before do
          @sYear = 2013
          @eYear = 2014
          @releases = []
          (@sYear..@eYear).each do |year|
            seasons.each do |season|
              Release.create(year: year,season: season)
            end
            @releases.push(*Release.where(year: year))
          end
          Work.register_annict_data(@releases)
        end
        it "データの数が増えていること" do
          expect(Work.count > previous_count).to be_truthy
        end
        it "最後のデータの作品の年とシーズンが増加分の年と冬になっていること" do
          year = Work.last.release.year
          season = Work.last.release.season
          expect(year === @eYear && season === "冬").to be_truthy
        end
      end
    end
  end
end
