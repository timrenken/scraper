class Scrape
  
  attr_accessor :title, :hotness, :image_url, :synopsis, :rating, :genre, :director, :release_date, :runtime, :failure
  
  def scrape_new_movie
    begin
      doc = Nokogiri::HTML(open("http://www.rottentomatoes.com/m/the_martian/"))
      
      doc.css('script').remove
      self.title = doc.at("//h1[@itemprop = 'name']").text
      self.hotness = doc.at("//span[@itemprop = 'ratingValue']").text.to_i
      self.image_url = doc.at_css('#movie-image-section img')['src']
      self.synopsis = doc.css("#movieSynopsis").text
      self.rating = doc.at("//td[@itemprop = 'contentRating']").text
      self.genre = doc.at("//span[@itemprop = 'genre']").text
      self.director = doc.at("//span[@itemprop = 'name']").text
      self.release_date = doc.at("//td[@itemprop = 'datePublished']").text.to_date
      self.runtime = doc.at("//time[@itemprop = 'duration']").text
      return true
    rescue Exception => e
      self.failure = "Something went wrong with the scrape!"
    end
  end
  
end