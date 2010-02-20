require 'open-uri'
require 'cgi'

class GoogleSet
  class Error < StandardError
    attr_accessor :wrapped_exception
    def initialize(ex)
      @wrapped_exception = ex
      set_backtrace(ex.backtrace)
    end
  end

  def self.for(*terms)
    path = "http://labs.google.com/sets?&#{query_string(*terms)}"
    result = open(path).read
    result.scan(%r{<a href="http://www\.google\.com/search\?hl=en&amp;q=[^"]+">(.*?)</a>}).map {|i| i.to_s}
  rescue StandardError => e
    raise GoogleSet::Error.new(e)
  end

private
  def self.query_string(*terms)
    params = terms.inject({}) do |hash, term|
      hash["q#{hash.size + 1}"] = term
      hash
    end

    params.map {|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
  end
end
