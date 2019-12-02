module EducatorResourcesHelper
  def self.all_educator_resources
    Rails.cache.fetch('educator_resources') do
      YAML.load_file(Rails.root + 'lib/educator_resources/educator_resources.yml')
    end
  end
end