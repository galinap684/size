namespace :dresses do
  desc "fill database with scraped dresses"
  task fetch: :environment do
    require 'nokogiri'
    require 'httparty'
    require 'open-uri'


    url = "https://www.revolve.com/dresses/br/a8e981/?navsrc=main&sortBy=newest"
    unparsed_page = HTTParty.get(url)

    parsed_page = Nokogiri::HTML(unparsed_page)

    dresses = Array.new

    dress_cards = parsed_page.css('div.plp_image_wrap.u-center')

    allDressNamesCurrentlyinDB = [];

    for d in Dress.all do
      allDressNamesCurrentlyinDB << d.name
    end 

    page = 1

      #navigating to the inner page for the size info
    dress_cards.each do |dress_listing|

      inner_url = "https://www.revolve.com#{dress_listing.at('a')["href"]}"

      inner_html = open(inner_url)
      sleep 1 until inner_html
      parsed_inner_page = Nokogiri::HTML(inner_html)

      array = parsed_inner_page.css('li.size-options__item')
        
      i = 0
      sizingarray = []
        
      while i < array.length
        singlesize = array[i]
        sizingarray << singlesize.css('span.push-button__copy').text
        i += 1
      end
          
      dress = {
        name: dress_listing.css('div.product-name').text,
        company: dress_listing.css('div[itemprop="brand"]').text,
        sizes: "{#{sizingarray.join(", ")}}",
        color: parsed_inner_page.css('span.u-font-primary.u-margin-l--md.selectedColor').text,
        url: "https://www.revolve.com#{dress_listing.at('a')["href"]}"
      }
          

      string = parsed_inner_page.css('span#markdownPrice').text
      string[0] = ''

      if string.include?(",")
        final_value = string.delete ","
      else
        final_value = string.to_i
      end

      dress[:price] = final_value

      if array.length == 0 || allDressNamesCurrentlyinDB.include?(dress[:name])
        puts "the dress #{dress[:name]} is sold out or it's already in table"
        puts ""
      else
        dresses << dress
        puts "Adding #{dress[:name]} which comes in #{dress[:sizes]} in the color #{dress[:color]} at a price of #{dress[:price]} because it does not exist in the DB yet"
        puts ""
          
        @dress = Dress.new
        @dress.name = dress[:name]
        @dress.brand = dress[:company]
        @dress.size = dress[:sizes]
        @dress.color = dress[:color]
        @dress.price = dress[:price]
        @dress.url = dress[:url]
        @dress.save
      
        # conn = PG.connect(dbname: 'galinapodstrechnaya', user: 'galinapodstrechnaya')
        #conn.exec("update dresses (name, price, brand, color, size) values ('#{dress[:name]}', #{dress[:price]}, '#{dress[:company]}', '#{dress[:color]}', '#{dress[:sizes]}')")

      end 
    end
  end 



  desc "Delete certain duplicate dresses."
  task clean: :environment do
    Dress.all.each do |dress|
      if dress.name == "Nat Dress" || dress.name == "Baby Please Dress"
        dress.destroy!
      end
    end 
  end

  #this doesn't work atm
  desc "Update all dresses"
  task update: :environment do
    Dress.all.each do |dress|
      dress.update_all
    end
  end

end
