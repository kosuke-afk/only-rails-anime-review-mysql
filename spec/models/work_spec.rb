require 'rails_helper'

RSpec.describe Work do
  describe "check_dupplicate?メソッド" do
    let!(:release)  {Release.create(year: 2011, season: "春")}
    context "データの重複がない" do
      let!(:work)  {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 3}}
      it "falseが返ってくる" do
        @work = Work.create(**work.merge({release_id: release.id}))
        expect(TestMethod::Work.check_duplication?(work[:title_kana])).to be_falsey
      end
    end
    context "データの重複がある" do
      let!(:work1)  {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 4}}
      let!(:work2) {{title_kana: "よすがのそら",image: "",episode_count: 12,media: "TV",annict_id: 5}}
      it "trueが返ってくる" do
        Work.create(**work1.merge({release_id: release.id}))
        @dupplicate_work = Work.create(**work2.merge({release_id: release.id}))
        expect(TestMethod::Work.check_duplication?(work1[:title_kana])).to be_truthy
      end
    end
  end

  describe "create_sample_dataメソッド" do
    let!(:release)  {Release.create(year: 2011, season: "春")}
    it "指定した数のデータが作成できていること" do
      TestMethod::Work.create_sample_data(quantity: 20)
      expect(Work.count === 20).to be_truthy
    end
  end

  describe "create_or_updateメソッド" do
    let!(:work) {{"title" => "ヨスガのソラ","title_kana" => "よすがのそら","images" => {"recommended_url" => ""},"episode_count" => 12,"media" => "TV","id" => 4}}
    let!(:release)  {Release.create(year: 2011, season: "春")}
    it "データが作成できていること" do
      expect(Work.first).to be_falsey
      @work = Work.create_or_update(work: work, release_id: release.id)
      expect(Work.first).to be_truthy
    end

    it "重複データを作成しないこと" do
      Work.create_or_update(work: work, release_id: release.id)
      @work = Work.create_or_update(work: work, release_id: release.id)
      expect(TestMethod::Work.check_duplication?(work["title_kana"])).to be_falsey
    end
  end

  describe "register_annict_dataメソッド" do
    let!(:seasons) {["春","夏","秋","冬"]}
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
      it "与えられた期間の作品が正しく登録されていること" do
        (@sYear..@eYear).each do |year|
          seasons.each do |season|
            eg_season = Work.change_season_for_eg(season)
            database_works = Release.find_by(year: year,season: season).works
            annict_data_count = Annict::Work.fetch_all_works(year: year, season: eg_season)["total_count"]
            expect(database_works.count === annict_data_count).to be_truthy
          end
        end
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
        it "追加した分の期間の作品が増えていること" do
          year = Work.order(created_at: "asc").last.release.year
          season = Work.order(created_at: "asc").last.release.season
          expect(year === @eYear && season === "冬").to be_truthy
        end
      end
    end
  end
end
