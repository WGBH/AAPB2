require 'rails_helper'

describe AdvancedController do
  describe 'redirection' do
    assertions = [
      [{ all: 'all of these' }, '+all +of +these'],
      [{ title: 'some title' }, '+titles:"some title"'],
      [{ exact: 'exactly these' }, '+(captions_unstemmed:"exactly these" OR text_unstemmed:"exactly these" OR titles_unstemmed:"exactly these" OR contribs_unstemmed:"exactly these" OR title_unstemmed:"exactly these" OR contributing_organizations_unstemmed:"exactly these" OR producing_organizations_unstemmed:"exactly these" OR genres_unstemmed:"exactly these" OR topics_unstemmed:"exactly these")'],
      [{ any: 'any of these' }, 'any OR of OR these'],
      [{ none: 'none of these' }, '-none -of -these'],
      [{ all: 'all', title: 'title', exact: 'exact', any: 'any', none: 'none' },
       '+all +titles:"title" +"exact" any -none']
    ]
    assertions.each do |params, query|
      it "handles #{params}" do
        # Form submission from browser will include all fields.
        post 'create', { all: '', title: '', exact: '', any: '', none: '' }.merge(params)
        expect(CGI.unescape(response.redirect_url.split('=')[1])).to eq(query)
      end
    end
  end
end
