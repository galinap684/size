namespace :dresses do
  desc "fill database with scraped dresses"
  task fetch: :environment do
    require 'nokogiri'
    require 'httparty'
    require 'open-uri'
       # clean database to avoid duplicates
      #Job.all.each do |job|
      #   job.destroy!
      # end



      url = "https://www.revolve.com/dresses/br/a8e981/?navsrc=main&sortBy=newest"
      unparsed_page = HTTParty.get(url)

      parsed_page = Nokogiri::HTML(unparsed_page)

      dresses = Array.new
      dress_cards = parsed_page.css('div.plp_image_wrap.u-center')

      #to grab the size: parsed_page.css('label.filters__size-copy').first.text

      page = 1


        #navigating to the inner page for the size info

        dress_cards.each do |dress_listing|

          inner_url = "https://www.revolve.com#{dress_listing.at('a')["href"]}"

          inner_html = open(inner_url)
          sleep 1 until inner_html
          parsed_inner_page = Nokogiri::HTML(inner_html)

          array = parsed_inner_page.css('span.size-options__label-copy')
          i = 0
          sizingarray = []

          while i < array.length
          singlesize = array[i]

          sizingarray << singlesize.text
          i += 1
          end


          dress = {
          name: dress_listing.css('div.product-name').text,
          company: dress_listing.css('div[itemprop="brand"]').text,
          sizes: "{#{sizingarray.join(", ")}}",
          color: parsed_inner_page.css('span.u-font-primary.u-margin-l--md.selectedColor').text
          }

=begin

          if dress_listing.css('div#salePriceContainer')
            #removing the $ sign and converting the price to an integer
            string = parsed_inner_page.css('span#markdownPrice').text
            string[0] = ''
            puts string
            byebug
            dress[:price] = string.to_i
          else
            string = parsed_inner_page.css('span[itemprop="price"]').text

            string[0] = ''
            puts string
            byebug
            dress[:price] = string.to_i
          end

=end

    #if dress_listing.css('div#salePriceContainer')
      #removing the $ sign and converting the price to an integer


      string = parsed_inner_page.css('span#markdownPrice').text
      string[0] = ''


      if string.include?(",")
        final_value = string.delete ","
     else
       final_value = string.to_i
     end

      dress[:price] = final_value
    #end



      if array.length == 0
        puts "the dress #{dress[:name]} is sold out"
        puts ""
      else

       dresses << dress

        #  puts "Added #{dress[:name]} which comes in #{dress[:sizes]} in the color #{dress[:color]} for #{dress[:price]}"
      #    puts ""

      @dress = Dress.new
      @dress.name = dress[:name]
      @dress.brand = dress[:company]
      @dress.size = dress[:sizes]
      @dress.color = dress[:color]
      @dress.price = dress[:price]
      @dress.save


          #conn = PG.connect(dbname: 'galinapodstrechnaya', user: 'galinapodstrechnaya')
          #conn.exec("update dresses (name, price, brand, color, size) values ('#{dress[:name]}', #{dress[:price]}, '#{dress[:company]}', '#{dress[:color]}', '#{dress[:sizes]}')")

         end
         #byebug
         end


   end


         desc "Delete all jobs."
      task clean: :environment do
        dress.all.each do |dress|
          dress.destroy!
        end
      end




  end
