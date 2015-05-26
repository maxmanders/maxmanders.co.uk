require "nokogiri"

module Jekyll
  module Filters
    def summarize(str, splitstr = '<!--more-->')
      return _strip_html(str.split(splitstr)[0])
    end
    def description(str, splitstr = '<!--more-->')
      return Maruku.new(str.split(splitstr)[0]).to_html.gsub(/<\/?[^>]*>/, "").strip
    end
    def _strip_html(str, allowed = ['h1','h2','h3','h4','a','p','img','strong','em','br','i','b','u','ul','li'])
      unless str.nil?
        s = Nokogiri::HTML(str)
        %w(h1 h2 h3 h4).each do |heading|
          s.search("//#{heading}").remove
        end
        return s.inner_html.gsub(/<(\/|\s)*[^(#{allowed.join('|') << '|\/'})][^>]*>/,'')
      end
    end
  end
end
