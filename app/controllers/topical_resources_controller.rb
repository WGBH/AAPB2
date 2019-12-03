class TopicalResourcesController < ApplicationController
  def index
    @topical_resources = all_topical_resources.sort_by { |key| key["date"] }.reverse
    @page_title = 'Topical Resources'
  end

  private

  def all_topical_resources
    Rails.cache.fetch('topical_resources') do
      YAML.load_file(Rails.root + 'lib/educator_resources/topical_resources.yml')
    end
  end
end
