class DownloadableResourcesController < ApplicationController
  def index
    @downloadable_resources = all_downloadable_resources
    @page_title = 'Downloadable Resources'
  end

  private

  def all_downloadable_resources
    Rails.cache.fetch('downloadable_resources') do
      YAML.load_file(Rails.root + 'lib/educator_resources/downloadable_resources.yml')
    end
  end
end
