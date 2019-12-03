require_relative '../../app/helpers/educator_resources_helper'
require 'active_support'

describe EducatorResourcesHelper do
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }
  let(:educator_resources_keys) { %w( title path thumbnail ) }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  describe '.all_educator_resources' do
    it 'returns an array of educator_resources' do
      expect(EducatorResourcesHelper.all_educator_resources).to be_a Array
    end

    it 'returns expected data format' do
      expect(EducatorResourcesHelper.all_educator_resources.map(&:keys).flatten.uniq).to eq(educator_resources_keys)
    end
  end
end
