require 'rails_helper'

RSpec.describe EpisodeRate, type: :model do
  before do 
    Release.register(2011,2012)
    10.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@gmail.com"
      password ="password"
      User.create!(
        name: name,
        email: email, 
        password: password,
        password_confirmation: password
      )
    end
    TestMethod::Work.create_sample_data(quantity: 50)
    TestMethod::Episode.limit_register(20)
    EpisodeRate.create_sample_rates(title_counts: 20)
  end
  describe "create_sample_rates" do
    it "10人のユーザーのエピソード評価が20作品分登録されていること" do
      ep_rates_each_user = EpisodeRate.all.group_by { |ep_rate| ep_rate[:user_id]}.values
      user_count = ep_rates_each_user.count
      expect(user_count === 10).to be_truthy
      ep_rates_each_user.each do |ep_rates|
        work_count = ep_rates.group_by { |ep_rate| ep_rate[:work_id]}.values.count
        expect(work_count === 20).to be_truthy
      end
    end
  end
end