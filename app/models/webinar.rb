require_relative '../../lib/solr'
require 'nokogiri'
require 'cmless'

class Webinar < Cmless
  ROOT = (Rails.root + 'app/views/webinars').to_s

  attr_reader :thumbnail_html
  attr_reader :summary_html
  attr_reader :resources_html
  attr_reader :webinar_html

  def self.all_webinars
    @all_webinars ||=
      Webinar.select { |web| !web.path.match(%r{\//}) }
  end

  def thumbnail_url
    @thumbnail_url ||=
      Nokogiri::HTML(thumbnail_html).xpath('//img[1]/@src').first.text
  end

  def summary_html
    doc = Nokogiri::HTML::DocumentFragment.parse(@summary_html)
    doc.inner_html
  end

  def resources_html
    doc = Nokogiri::HTML::DocumentFragment.parse(@resources_html)
    doc.inner_html
  end

  def webinar_html
    doc = Nokogiri::HTML::DocumentFragment.parse(@webinar_html)
    doc.inner_html
  end
end
