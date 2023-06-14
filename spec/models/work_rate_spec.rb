require 'rails_helper'

RSpec.describe WorkRate, type: :model do
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
    it "10人のユーザーに20作品ずつの作品評価が存在すること" do
      WorkRate.create_sample_rates
      user_count = WorkRate.all.group_by { |rate| rate.user_id }.values.count
      work_count_each_user = WorkRate.all.group_by { |rate| [rate.user_id,rate.work_id]}.values.count
      expect(user_count === 10).to be_truthy
      expect(work_count_each_user === 200).to be_truthy
    end
  end
end