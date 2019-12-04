require 'rails_helper'

describe DownloadableResourcesController do
  describe 'index' do
    let(:expected_keys) { %w( title link thumbnail ) }

    it 'gets data in the expected format' do
      get 'index'
      expect(assigns(:downloadable_resources).map(&:keys).flatten.uniq).to eq (expected_keys)
    end
  end
end
