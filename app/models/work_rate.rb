class WorkRate < ApplicationRecord
  belongs_to :work, primary_key: :annict_id
  belongs_to :user
end
