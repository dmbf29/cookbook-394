class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  # .new -> runs the intialize
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @difficulty = attributes[:difficulty]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end

# pass a hash to create an instance
# p Recipe.new(description: 'candy', name: 'chocolate', done: true)
# recipe =  Recipe.new(whatever: 'hello')

# recipe.mark_as_done!
