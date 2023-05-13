require 'rails_helper'

RSpec.describe Annict do
  describe "Workクラス" do
    describe "fetch_all_worksメソッド" do
      let!(:works) {Annict::Work.fetch_all_works(year:2011,season:"spring")}
      it "Hashに変換できていること" do
        expect(works.kind_of?(Hash)).to be_truthy
      end
      it "Annictからデータが取得できていること" do
        expect(works["works"][0]["title"]).to be_truthy
      end
      it "取得してきたデータの数にバラ付きがないこと" do
        second_request = Annict::Work.fetch_all_works(year:2011,season:"spring")
        expect(works["total_count"] === second_request["total_count"]).to be_truthy
        expect(works["works"][0]["title"] === second_request["works"][0]["title"]).to be_truthy
      end
    end

    describe "fetch_worksメソッド" do
      let!(:works) {Annict::Work.fetch_works_each_page(year:2011,season:"spring",page: 2)}
      it "JSONデータが取得できていること" do
        expect(works[0].kind_of?(Hash)).to be_truthy
      end
      it "Annictからデータが取得できていること" do
        expect(works[0]["title"]).to be_truthy
      end
      it "取得してきたデータにバラ付きがないこと" do
        second_request = Annict::Work.fetch_works_each_page(year:2011,season:"spring",page: 2)
        expect(works.count === second_request.count).to be_truthy
        expect(works[0]["title"] === second_request[0]["title"]).to be_truthy
      end
    end

    describe "fetch_workメソッド" do
      let!(:title) {"むさしの"}
      let!(:quantity) {15}
      context "引数がtitleの場合" do
        it "指定したタイトルのデータが取れていること" do
          work = Annict::Work.fetch_work(title: title)
          expect(work).to be_truthy
        end
      end
      context "引数がquantityの場合" do
        it "指定した個数の作品のデータが取れてきていること" do
          work = Annict::Work.fetch_work(quantity: quantity)
          binding.break
          expect(work.count === quantity).to be_truthy
        end
      end
    end
  end

  describe "Episodeクラス" do
    describe "fetch_episodesメソッド" do
      it "指定した作品のエピソードが取得できていること" do
        release = Release.create(year: 2022, season: "夏")
        annict_data = Annict::Work.fetch_work(title: "むさしの")[0]
        work = Work.create(title: annict_data["title"],annict_id: annict_data["id"],release_id: release.id)
        episodes = Annict::Episode.fetch_episodes(work)
        binding.break
        expect(episodes[0]["work"]["title"] === annict_data["title"]).to be_truthy
      end
    end
  end

  describe "Castクラス" do
    describe "fetch_castsメソッド" do
      it "指定した作品のcastを取得できていること" do
        release = Release.create(year: 2022,season: "春")
        work_data = Annict::Work.fetch_work(title: "むさしの")[0]
        work = Work.create(title: work_data["title"],annict_id: work_data["id"],release_id: Release.first.id)
        casts = Annict::Cast.fetch_casts(work)
        expect(casts.count > 0).to be_truthy
      end
    end
  end
end