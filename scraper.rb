	require 'nokogiri'
	require 'open-uri'
	require 'pry'

# class Scraper

# 	def scrape_page

		students = []

		page = Nokogiri::HTML(open("https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die"))
		page.css("div.leftContainer").each do |container|
			container.css("div.elementList").each do |element|
				title = element.css("a.leftAlignedImage").attr('title').text
				author = element.css("div.authorName__container a").text
				published = element.css("span.greyText").text.gsub(/\s+/, "")[-4..-1]
				students << { :book_title => title, :book_author => author, :book_published => published}
			end
		end

		binding.pry


		# page.css("div.leftContainer").each do |container|
		# 	container.css("elementList").each do |element|
		# 		book_title = element.css("div.left ")
		# 		book_author = element.css("div.left div.author_Name__container").text
		# 		book_published =
		# 	end
		# end

# 	end

# end