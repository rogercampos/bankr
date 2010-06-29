require 'bankr/scrapers/la_caixa'

module Bankr
  
  class Bankr

    def initialize(options)
      @scraper = eval("Scrapers::#{options.delete(:bank)}").new(options)
    end

    def logged_in?
      @scraper.logged_in?
    end

  end

end
