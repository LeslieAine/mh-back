class About < ApplicationRecord
  belongs_to :user

  attribute :description, default: 'No description yet'
  attribute :interests, default: 'No interests yet'
  attribute :intentions, default: 'No intentions yet'
end
