require 'json'
require 'google_dfp/size'
require 'google_dfp/tag'

module GoogleDFP
  
  class Engine < ::Rails::Engine
  end
  
  module ViewHelper
    def dfp_tag(name, targeting=nil, id=nil)
      tag  = GoogleDFP::Tag.get(name)
      data = tag.data
      data = data.merge(targeting: targeting) if targeting.present?

      content_tag :div,
        "",
        id:    id || "dfp-#{name.gsub("_", "-")}",
        class: 'google-dfp',
        data:  data
    end
  end

end

ActionView::Base.send :include, GoogleDFP::ViewHelper
