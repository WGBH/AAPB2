require 'rails_helper'
require_relative '../support/validation_helper'

describe 'Homepage' do

  it 'works' do
    visit '/'
    expect(page.status_code).to eq(200)
    expect(page).to have_text('TODO: home page')
    expect_fuzzy_xml
  end

end