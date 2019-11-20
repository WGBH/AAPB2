require_relative '../models/special_collection'

class TopicalResourcesController < ApplicationController
  def index
    @topical_resources = YAML.load_file(Rails.root + 'lib/resource_sets/topical_resources.yml')
    @page_title = 'Topical Resources'
  end
end
