require_relative 'view'
require_relative 'scrape_bbc_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end
  # inside instance methods, always have access to instance variables

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description
    prep_time = @view.ask_user_for('prep time')
    difficulty = @view.ask_user_for('difficulty')
    recipe = Recipe.new(
      name: name,
      description: description,
      prep_time: prep_time,
      difficulty: difficulty
    )
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    index = @view.ask_user_for_index_to_delete
    @cookbook.remove_recipe(index)
  end

  def import
    # Ask a user for a keyword to search
    keyword = @view.ask_user_for('keyword')
    # Make an HTTP request to the recipe’s website with our keyword
    bbc_recipes = ScrapeBbcService.new(keyword).call
    # Display them in an indexed list
    @view.display_recipes(bbc_recipes)
    # Ask the user which recipe they want to import (ask for an index)
    index = @view.ask_user_for("number you'd like to import?").to_i - 1
    # Add it to the Cookbook
    recipe_to_import = bbc_recipes[index]
    @cookbook.add_recipe(recipe_to_import)
  end

  def mark
    # list the recipes for the user
    display_recipes
    # index = ask the user which one is done
    index = @view.ask_user_for("number have you finshed?").to_i - 1
    # find the recipe with the index
    @cookbook.mark_recipe(index)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end
end











