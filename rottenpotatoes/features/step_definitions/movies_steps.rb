# features/step_definitions/movies_steps.rb
Given("I am on the movies page") do
  visit movies_path
end

Then("I should see {string}") do |text|
  assert page.has_content?(text)
end

Given("a movie exists with title {string}") do |title|
  @movie = Movie.create!(title: title, rating: "PG", description: "Test description")
end

When("I visit the movie page") do
  visit movie_path(@movie)
end

When("I follow {string}") do |link|
  click_link link
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I press {string}") do |button|
  click_button button
end

Then("I should not see {string}") do |text|
  assert !page.has_content?(text)
end

When("I select {string} from {string}") do |value, field|
  select value, from: field
end

Then("I should see both {string} and {string}") do |text1, text2|
  assert page.has_content?(text1)
  assert page.has_content?(text2)
end

Then("{string} should appear before {string}") do |text1, text2|
  position1 = page.body.index(text1)
  position2 = page.body.index(text2)
  assert position1 < position2, "'#{text1}' should appear before '#{text2}'"
end
Then("I should be on the movies page") do
  assert current_path == movies_path, "Expected to be on #{movies_path}, but was on #{current_path}"
end

# Alias para verificar se uma mensagem está na página (pode ser notice ou error)
Then("I should see the message {string}") do |message|
  assert page.has_content?(message), "Expected to see '#{message}' on the page"
end