class Search < ApplicationRecord
  has_many :contributors, dependent: :destroy

  validates :url, presence: true
  validates :url, format: { with: /\Ahttps:\/\/github.com\//, message: I18n.t('search.validate_format') }

  before_create :delete_last_search
  after_create :load_contributors

  def repository
    url.split('/')[-2..-1].join('/')
  end

  private

  def delete_last_search
    Search.first.try(:destroy)
  end

  def load_contributors
    three_best_contributors = Octokit.contributors(repository)[0..2]
    three_best_contributors.each_with_index do |contributor, position|
      contributors.create(position: position + 1, username: contributor[:login])
    end
  end
end
