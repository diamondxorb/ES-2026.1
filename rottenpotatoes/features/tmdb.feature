Feature: User can add movie by searching for it in The Movie Database (TMDb)
    Background: Start from the Search form on the movies page
        Given I am on the movies page
        Then I should see "Search TMDb for a movie"

    Scenario: Try to add nonexistent movie (sad path)
        When I fill in "Search Terms" with "Movie That Does Not Exist"
        And I press "Search TMDb"
        Then I should be on the movies page
        And I should see "'Movie That Does Not Exist' was not found in TMDb."