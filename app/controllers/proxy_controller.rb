require 'open-uri'
require 'uri'

class ProxyController < ApplicationController

    @@uri = 'http://www.sherpa.ac.uk/romeo/api29.php'

    def fetch
        querystring = {
            :versions => 'all',
            :qtype => 'exact'
        }

        if params[:refable] == 'journals'
            journal = Journal.find(params[:id])
            querystring[:jtitle] = journal.name
        elsif params[:refable] == 'publishers'
            publisher = Publisher.find(params[:id])
            querystring[:pub] = publisher.name
        end

        if params[:romeopub] and params[:zetocpub]
            querystring[:romeopub] = params[:romeopub]
            querystring[:zetocpub] = params[:zetocpub]
        end

        url = URI.parse(@@uri)
        url.query = URI.encode_www_form(querystring)

        open(url) do |res|
            @body = res.read
        end

        render xml: @body
    end
end
