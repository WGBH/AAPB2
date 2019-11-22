require_relative '../../app/models/webinar'

describe Webinar do
  describe 'correctly configured' do
    class MockWebinar < Webinar
      ROOT = (Rails.root + 'spec/fixtures/webinars').to_s
    end

    webinar = MockWebinar.find_by_path('test-webinar')

    describe '.thumbnail_url' do
      it 'returns the thumbnail for the webinar' do
        expect(webinar.thumbnail_url).to eq("https://s3.amazonaws.com/americanarchive.org/special-collections/test-webinar.jpg")
      end
    end

    describe '.path' do
      it 'returns the path for the webinar' do
        expect(webinar.path).to eq('test-webinar')
      end
    end

    describe '.title' do
      it 'returns the title of the webinar' do
        expect(webinar.title).to eq('Test Webinar')
      end
    end

    describe '.title_html' do
      it 'returns the title HTML for the webinar' do
        expect(webinar.title_html).to eq('Test Webinar')
      end
    end

    describe '.summary_html' do
      it 'returns the summary HTML for the webinar' do
        expect(webinar.summary_html).to eq('<p>Test summary...</p>')
      end
    end

    describe '.resources_html' do
      it 'returns the resources HTML for the webinar' do
        expect(webinar.resources_html).to eq('<p>Test resources...</p>')
      end
    end

    describe '.webinar_html' do
      it 'returns the webinar HTML for the webinar' do
        expect(webinar.webinar_html).to eq('<iframe src="//www.slideshare.net/slideshow/embed_code/key/cn1piwVFVentub" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>')
      end
    end

    describe 'error handling' do
      it 'raises an error for bad paths' do
        expect { MockWebinar.find_by_path('no/such/path') }.to raise_error(Cmless::Error)
      end
    end
  end
end
