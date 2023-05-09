require 'rails_helper'

RSpec.describe Annict do
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
    let!(:works) {Annict::Work.fetch_works(year:2011,season:"spring",page: 2)}
    it "JSONデータが取得できていること" do
      expect(works[0].kind_of?(Hash)).to be_truthy
    end
    it "Annictからデータが取得できていること" do
      expect(works[0]["title"]).to be_truthy
    end
    it "取得してきたデータにバラ付きがないこと" do
      second_request = Annict::Work.fetch_works(year:2011,season:"spring",page: 2)
      expect(works.count === second_request.count).to be_truthy
      expect(works[0]["title"] === second_request[0]["title"]).to be_truthy
    end
  end
end