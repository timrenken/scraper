class Scrape
  
  attr_accessor :title, :hotness, :image_url, :synopsis, :rating, :genre, :director, :release_date, :runtime, :failure
  
  def scrape_new_movie(url)
    begin
      doc = Nokogiri::HTML(open(url))
      
      doc.css('script').remove
      self.title = doc.at("//h1[@itemprop = 'name']").text
      self.hotness = doc.at("//span[@itemprop = 'ratingValue']").text.to_i
      self.image_url = doc.at_css('#movie-image-section img')['src']
      self.rating = doc.at("//td[@itemprop = 'contentRating']").text
      self.genre = doc.at("//span[@itemprop = 'genre']").text
      self.director = doc.at("//span[@itemprop = 'name']").text.tidy_bytes
      self.release_date = doc.at("//td[@itemprop = 'datePublished']").text.to_date
      self.runtime = doc.at("//time[@itemprop = 'duration']").text
      self.synopsis = doc.css("#movieSynopsis").text.tidy_bytes
      return true
    rescue Exception => e
      self.failure = "Something went wrong with the scrape!"
    end
  end
  
end