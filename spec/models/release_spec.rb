require 'rails_helper'

RSpec.describe Release do
  describe "check_duplication?メソッド" do
    before do 
      @year = 2014
      @season = "春"
      Release.create(year: @year, season: @season)
    end
    context "重複している場合" do
      it "trueが返る" do
        @release = Release.create(year: @year, season: @season)
        expect(TestMethod::Release.check_duplication?(@year,@season)).to be_truthy
      end
    end
    context "重複していない場合"do
      it "falseが返る" do
        @release = Release.first
        expect(TestMethod::Release.check_duplication?(@release.year,@release.season)).to be_falsey
      end
    end
  end
  
  describe "#register" do
    before do 
      Release.register(2011,2013)
    end
    it "重複したデータを作成しない" do
      Release.register(2011,2013)
      @releases = Release.all
      @releases.each do |release|
        expect(TestMethod::Release.check_duplication?(release.year,release.season)).to be_falsey
      end
    end
  end
end
