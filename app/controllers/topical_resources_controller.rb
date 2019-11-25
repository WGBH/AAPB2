require_relative '../models/special_collection'

class TopicalResourcesController < ApplicationController
  def index
    @topical_resources = all_topical_resources
    @page_title = 'Topical Resources'
  end

  private

  def all_topical_resources
    Rails.cache.fetch('canonical_urls') do
      YAML.load_file(Rails.root + 'lib/resource_sets/topical_resources.yml')
    end
  end
end
