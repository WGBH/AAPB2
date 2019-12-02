module ResourceSetsHelper
  def self.all_resource_sets
    Rails.cache.fetch('resource_sets') do
      YAML.load_file(Rails.root + 'lib/resource_sets/resource_sets.yml')
    end
  end
end