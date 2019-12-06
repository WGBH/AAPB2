class TopicalResourcesController < ApplicationController
  def index
    @topical_resources = topical_resources.sort_by { |hash| hash["date"] }.reverse
    @years = topical_resources.map { |res| res["year"] }.uniq.sort.reverse
    @page_title = 'Topical Blog Posts'
  end

  private

  def topical_resources
    add_display_years(all_topical_resources)
  end

  def all_topical_resources
    Rails.cache.fetch('topical_resources') do
      YAML.load_file(Rails.root + 'lib/educator_resources/topical_resources.yml')
    end
  end

  def add_display_years(resources)
    resources.each do |res|
      res["year"] = res["date"].year
    end
    resources
  end
end
