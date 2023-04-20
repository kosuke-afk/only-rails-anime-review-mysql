class Cast < ApplicationRecord
  belongs_to :work, primary_key: :annict_id
end
