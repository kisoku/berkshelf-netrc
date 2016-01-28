require 'berkshelf'
require 'netrc'
require 'uri'

module BerkshelfNetrc
  class Helper

    def self.install(*args)
      new(*args).install
    end

    def initialize
    end

    def install
      Berkshelf::Source.class_exec do
	define_method(:initialize) do |uri|
	  @uri = Berkshelf::SourceURI.parse(uri)
	  @universe = nil

	  netrc = Netrc.read
          host = URI.parse(uri).host
	  if netrc[host]
	    login, pass = netrc[host]
	    builder = Faraday::RackBuilder.new do |b|
	      b.response :parse_json
	      b.request :basic_auth, login, pass
	      b.request :retry,
                # XXX this sucks
		max: 3,
                interval: 0.5,
		exceptions: [
		  Faraday::Error::TimeoutError,
		  Errno::ETIMEDOUT
		]
	      b.adapter :httpclient
	    end
	    @api_client = Berkshelf::APIClient.new(
	       uri,
	       builder: builder,
	       ssl: {verify: Berkshelf::Config.instance.ssl.verify}
	    )
	  else
	    @api_client = Berkshelf::APIClient.new(uri, ssl: {verify: Berkshelf::Config.instance.ssl.verify})
	  end
	end
      end
    end
  end
end
