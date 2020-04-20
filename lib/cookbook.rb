require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path = nil)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv if @csv_file_path
  end

  def add_recipe(recipe) # Instance of Recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def all
    @recipes
  end

  # update
  def mark_recipe(index)
    recipe = @recipes[index]
    # mark that recipe as done
    recipe.mark_as_done!
    # save to csv
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|\
      # p row # acting like a hash now
      row[:done] = row[:done] == 'true' # hash update
      @recipes << Recipe.new(row)
      #   name: row[:name],
      #   description: row[:description],
      #   prep_time: row[:prep_time],
      #   difficulty: row[:difficulty]
      # )
    end
    p @recipes
  end

  def save_csv
    return unless @csv_file_path

    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      # the headers turn into the keys in row!
      csv << ['name', 'description', 'prep_time', 'difficulty', 'done']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done?]
      end
    end
  end
end



