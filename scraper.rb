	require 'nokogiri'
	require 'open-uri'
	require 'pry'

# class Scraper

# 	def scrape_page

		page = Nokogiri::HTML(open("https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die"))
		page.css("div.leftContainer").each do |container|
			container.css("div.elementList").each do |element|
				title = element.css("a.leftAlignedImage").attr('title').text
				author = element.css("div.authorName__container a").text
				info = element.css("span.greyText").text
				binding.pry
			end
		end

		books = []


		# page.css("div.leftContainer").each do |container|
		# 	container.css("elementList").each do |element|
		# 		book_title = element.css("div.left ")
		# 		book_author = element.css("div.left div.author_Name__container").text
		# 		book_published =
		# 	end
		# end

# 	end

# end
