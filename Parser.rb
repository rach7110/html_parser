# 'Rachel\'s Book Parser'

# Gem: nokogiri for parsing information out of the html file from its css.
require 'nokogiri'
# Gem: json to output the desired infomration into a readable format (object with key/value pairs)
require 'json'

# Pasre the html file to get useful information-----------------------------
class Parse
	attr_accessor :title, :author, :price, :shipping_weight, :isbn_10

	# Ask the user for the book file to parse:
	def initialize 
		puts "Enter the file location & name..."
		book_file = gets.chomp
		# Opens and reads the html files:
		@page = Nokogiri::HTML(open(book_file))
	end

	def book_info
		@title = book_title
		@author = book_author 
		@price = book_price
		@shipping_weight = book_shipping_weight
		@isbn = book_isbn_10
	end

	def book_title
		title = @page.css('span#btAsinTitle').text
		puts "Title: #{title}"
	end

	def book_author
		author = @page.css('div.buying span a').text.split("Details")
		puts "Author: #{author}"
	end

	def book_price
		price = @page.css('b.priceLarge').text
		puts "Price: #{price}"
	end
# ----------BUG: Shipping Weight not parsing correctly---------------
	def book_shipping_weight
		shipping_weight = @page.css('table div.content ul').each do |li|
			if li.text.include?("Shipping Weight")
				puts "Shipping Weight: #{li}"
			end
		end

	end
# ----------BUG: & ISBN-10  not parsing correctly---------------
	def book_isbn_10
		@page.css('div.content ul').each do |li|
			if li.text.include?("ISBN-10")
				puts "Book ISBN-10: #{li}"
			end
		end
	end

end

