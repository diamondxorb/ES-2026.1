Feature: Movies management
    Scenario: List movies
        Given I am on the movies page
        Then I should see "Movies"

    Scenario: Create a new movie
        Given I am on the movies page
        When I follow "New movie"
        And I fill in "Title" with "Test Movie"
        And I fill in "Rating" with "PG"
        And I fill in "Description" with "A test description"
        And I press "Create Movie"
        Then I should see "Movie was successfully created"
        And I should see "Test Movie"

    Scenario: Show movie details
        Given a movie exists with title "Existing Movie"
        When I visit the movie page
        Then I should see "Existing Movie"
        And I should see "PG"

    Scenario: Edit a movie
        Given a movie exists with title "Editable Movie"
        When I visit the movie page
        And I follow "Edit this movie"
        And I fill in "Title" with "Updated Movie"
        And I press "Update Movie"
        Then I should see "Movie was successfully updated"
        And I should see "Updated Movie"

    Scenario: Delete a movie
        Given a movie exists with title "Deletable Movie"
        When I visit the movie page
        And I press "Destroy this movie"
        Then I should see "Movie was successfully destroyed"
        And I should not see "Deletable Movie"

    Scenario: View movie list after adding 2 movies and sort by title alphabetically
        Given I am on the movies page
        When I follow "New movie"
        And I fill in "Title" with "Zorro"
        And I fill in "Rating" with "PG"
        And I fill in "Description" with "Movie description"
        And I press "Create Movie"
        Then I should see "Movie was successfully created"
        When I am on the movies page
        And I follow "New movie"
        And I fill in "Title" with "Apocalypse Now"
        And I fill in "Rating" with "R"
        And I fill in "Description" with "Movie description"
        And I press "Create Movie"
        Then I should see "Movie was successfully created"
        When I am on the movies page
        And I select "Title (A-Z)" from "Sort by"
        And I press "Apply"
        Then I should see both "Apocalypse Now" and "Zorro"
        And "Apocalypse Now" should appear before "Zorro"