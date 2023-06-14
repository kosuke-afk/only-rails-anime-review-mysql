class Cast < ApplicationRecord
  belongs_to :work, primary_key: :annict_id

  def self.all_register
    works = Work.all
    works.each do |work|
      begin 
        casts = Annict::Cast.fetch_casts(work)
      rescue 
        break
      else
        casts.each do |cast|
          Cast.find_or_create_by(character: cast["character"]["name"],cast: cast["person"]["name"],work_id: work.annict_id)
        end
      end
    end
  end

end
