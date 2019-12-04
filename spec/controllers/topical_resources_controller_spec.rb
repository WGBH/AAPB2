require 'rails_helper'

describe TopicalResourcesController do
  describe 'index' do
    let(:expected_keys) { %w( title link thumbnail date ) }

    it 'gets data in the expected format' do
      get 'index'
      expect(assigns(:topical_resources).map(&:keys).flatten.uniq).to eq(expected_keys)
    end
  end
end
