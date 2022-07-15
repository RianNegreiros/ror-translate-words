class Word < ApplicationRecord
  belongs_to :language
  validates :value, :language, presence: true
end
