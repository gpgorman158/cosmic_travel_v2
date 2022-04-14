class Mission < ApplicationRecord
    belongs_to :planet
    belongs_to :scientist
    validates :name, :scientist_id, :planet_id, presence: true
    validates :scientist_id, uniqueness: {scope: :planet_id}
end
