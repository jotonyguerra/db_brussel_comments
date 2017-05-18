require "pg"
require "pry"
require "faker"
system "psql brussels_sprouts_recipes < schema.sql"
TITLES = [
  "Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"
]
@comments = []
30.times do
   @comments<<Faker::HarryPotter.quote
 end
# Write code to seed your database, here
def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

#inserts titles from constant into db
db_connection do |conn|
  TITLES.each do |name|
    conn.exec_params("INSERT INTO recipes (name) VALUES ($1)",[name])
  end
  conn.exec_params("INSERT into recipes (name) VALUES ($1)", ["Brussels Sprouts with Goat Cheese"])
end
#insert comments
db_connection do |conn|
  @comments.each do |comment|
    conn.exec_params("INSERT INTO comments (body, recipe_id) VALUES ($1,$2)", [comment,rand(1..11)])
  end
  random_comment = @comments.sample
  second_comment = @comments.sample
  conn.exec_params("INSERT INTO comments (body,recipe_id) VALUES ($1,$2)",[random_comment,12])
  conn.exec_params("INSERT INTO comments (body,recipe_id) VALUES ($1,$2)",[second_comment,12])


end

db_connection do |conn|
  @recipe_size = conn.exec_params("SELECT count(*) FROM recipes")
  @comment_size = conn.exec_params("SELECT count(*) FROM comments")
end
puts "rows in recipes = #{@recipe_size[0]}"
puts "rows in comments = #{@comment_size[0]}"
# db_connection do |conn|
