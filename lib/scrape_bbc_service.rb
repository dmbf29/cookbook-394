require 'nokogiri'
require 'open-uri'

class ScrapeBbcService

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}"
    html = open(url).read
    doc = Nokogiri::HTML(html) # nokogiri object
    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    doc.search('.node-recipe').take(5).map do |recipe|
      name = recipe.search('.teaser-item__title').text.strip
      description = recipe.search('.teaser-item__text-content').text.strip
      prep_time = recipe.search('.mins').text.strip
      difficulty = recipe.search('.teaser-item__info-item--skill-level').text.strip
      Recipe.new(
        name: name,
        description: description,
        prep_time: prep_time,
        difficulty: difficulty
      )
    end
  end
end
