class EpisodeRate < ApplicationRecord
  belongs_to :episode
  belongs_to :user
end
