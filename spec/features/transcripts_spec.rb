require 'rails_helper'
require_relative '../../scripts/lib/pb_core_ingester'
require_relative '../support/feature_test_helper'

describe 'Transcripts' do
  describe '#show' do
    xit 'renders SRT as HTML' do
      visit '/transcripts/1234'
      expect(page).to have_text('Raw bytes 0-255 follow'), missing_page_text_custom_error('Raw bytes 0-255 follow', page.current_path)
    end
  end
end
