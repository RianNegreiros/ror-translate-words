class Word < ApplicationRecord
  validates :value, :language, presence: true
  validates :language, inclusion: { in: LanguageList::COMMON_LANGUAGES.map(&:name) }
end
