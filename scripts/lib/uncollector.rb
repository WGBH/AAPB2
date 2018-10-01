require 'rexml/xpath'
require 'rexml/document'
require 'nokogiri'

module Uncollector
  def self.uncollect_string(string)
    # Uses Nokogiri to help handle special characters
    doc = REXML::Document.new(Nokogiri::XML(string).to_s)
    REXML::XPath.match(doc, '/*/*').map(&:to_s)
  end
end
