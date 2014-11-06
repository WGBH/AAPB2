require 'rexml/document'
require 'rexml/xpath'
require 'solrizer'

require_relative 'organization'

class PBCore
  def initialize(xml)
    @xml = xml
    @doc = REXML::Document.new xml
  end
  def asset_type
    @asset_type ||= xpath('pbcoreAssetType')
  end
  def asset_date
    @asset_date ||= xpath('pbcoreAssetDate') 
    # TODO figure out formats
    # TODO maybe filter by @dateType?
  end
  def titles
    @titles ||= xpaths('pbcoreTitle')
  end
  def title
    @title ||= begin
      titles = Hash[
        REXML::XPath.match(@doc, '/pbcoreDescriptionDocument/pbcoreTitle').map { |node|
          [
            REXML::XPath.first(node,'@titleType').value,
            node.text
          ]
        } 
      ]
      # TODO: get the right order.
      titles['program'] || titles['series'] || raise("Unexpected title types: #{titles.keys}")
    end
  end
  def genre
    @genre ||= xpaths('pbcoreGenre')
  end
  def id
    @id ||= xpath('pbcoreIdentifier[@source="http://americanarchiveinventory.org"]')
  end
  def ids
    @ids ||= xpaths('pbcoreIdentifier')
  end
  def organization_code
    @organization_code ||= xpath('pbcoreAnnotation[@annotationType="organization"]')
  end
  def organization
    @organization ||= Organization.find(organization_code)
  end
  def rights_code
    @rights_code ||= xpath('pbcoreRightsSummary/rightsEmbedded/AAPB_RIGHTS_CODE')
  end
  def media_type
    @media_type ||= begin
      media_types = xpaths('pbcoreInstantiation/instantiationMediaType').uniq.sort
      case media_types
      when ['Sound']
        'Sound'
      when ['Moving Image', 'Sound']
        'Moving Image'
      else
        raise "Unexpected media types: #{media_types}"
      end
    end
  end
  def digitized
    @digitized ||= xpaths('pbcoreInstantiation/instantiationGenerations').include?('Proxy') # TODO get the right value
  end
#  def text # TODO: do we need this? Or just use copy fields in the schema?
#    @text ||= [
#      REXML::XPath.match(@doc, '//text()').join(' ').gsub(/\s+/,' ').strip,
#      organization
#    ].join(' ')
#  end

  def to_solr
    doc = {'id' => id}
    Solrizer.insert_field(doc, 'xml', @xml, :displayable)
    # '@doc.root.to_s' is pretty good, but it can't guarantee character-by-character equality to the original
    
    (PBCore.instance_methods(false)-[:id,:to_solr]).each do |method|
      self.send(method).tap do |value|
        if [String, TrueClass, FalseClass, Array].include?(value.class)
          Solrizer.insert_field(doc, method, self.send(method), :stored_searchable) 
        end
      end
    end
    
    doc
  end
  
  private
  def xpath(xpath)
    REXML::XPath.match(@doc, '/pbcoreDescriptionDocument/'+xpath).tap do |matches|
      if matches.length != 1
        raise "Expected 1 match for '#{xpath}'; got #{matches.length}"
      else
        return matches.first.text
      end
    end
  end
  def xpaths(xpath)
    REXML::XPath.match(@doc, '/pbcoreDescriptionDocument/'+xpath).map{|l|l.text}
  end
end