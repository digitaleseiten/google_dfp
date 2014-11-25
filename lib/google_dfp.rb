require 'json'
require 'google_dfp/size'
require 'google_dfp/tag'

module GoogleDFP
  
  class Engine < ::Rails::Engine
  end
  
  module ViewHelper
    def dfp_tag(name, targeting=nil, id=nil)
      div_id = id || "dfp-#{name}"
      
      tag  = GoogleDFP::Tag.get(name)
      data = tag.data
      data = data.merge(targeting: targeting) if targeting.present?

      content_tag :div,
        "",
        id:    div_id.gsub("_", "-"),
        class: 'google-dfp',
        data:  data
    end
  end

end

ActionView::Base.send :include, GoogleDFP::ViewHelper
