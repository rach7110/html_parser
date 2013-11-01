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
		@title = puts book_title
		@author = puts book_author 
		@price = puts book_price
		@shipping_weight = puts book_shipping_weight
		@isbn_10 = puts book_isbn_10
	end

	def book_title
		title = @page.css('span#btAsinTitle').text
	end

	def book_author
		author = @page.css('div.buying span a').text.split("Details")
	end

	def book_price
		price = @page.css('b.priceLarge').text
	end

	def book_shipping_weight
		shipping_weight = @page.css('table div.content ul li')[6].text.split("pounds (View shipping rates and policies)")
	end

	def book_isbn_10
		isbn_10 = @page.css('table div.content ul li')[3].text
	end

end

# IMPORVEMENT OPTIONS:
# Change the book_shipping_weight method to pull out only the number and convert it to a float.

