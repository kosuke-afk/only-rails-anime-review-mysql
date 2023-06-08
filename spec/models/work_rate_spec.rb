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
    @users = User.all 
    TestMethod::Work.create_sample_data(quantity: 50)
    TestMethod::Episode.limit_register(20)
    @users.each do |user|
      EpisodeRate.create_sample_rates(title_counts: 20,user: user)
    end
  end
  describe "sample_work_rate" do
    it "10人のユーザーに20作品ずつの作品評価が存在すること" do
      WorkRate.sample_work_rate
      user_count = WorkRate.all.group_by { |rate| rate.user_id }.values.count
      work_count_each_user = WorkRate.all.group_by { |rate| [rate.user_id,rate.work_id]}.values.count
      binding.break
      expect(user_count === 10).to be_truthy
      expect(work_count_each_user === 200).to be_truthy
    end
  end
end