Feature: Playing a game
  As a player
  I want to play a game of hangman

  Background:
    Given there is a wordlist called "default" with the following data
      | word    |
      | testing |
      | another |
      | hangman |

  Scenario: Starting a game
    Given I see the home page
    When I click "New Game"
    And I click "Create Game"
    Then I should see a new game

  Scenario: Starting a game with different starting lives
    Given I see the home page
    When I click "New Game"
    And I enter 5 as Starting lives
    And I click "Create Game"
    Then I should see a new game
    And I should have 5 lives left

  Scenario: Making a valid guess
    Given I have a new game
    When I make a valid guess
    Then I should see my guess
    And I should have 1 correct guess
    And I should have no incorrect guesses
    And I should have lost no lives

  Scenario: Making an invalid guess
    Given I have a new game
    When I make an invalid guess
    Then I should see my guess
    And I should have no correct guesses
    And I should have 1 incorrect guess
    And I should have lost 1 life

  Scenario: Making multiple guesses
    Given I have a new game
    When I make 3 valid guesses
    And I make 2 invalid guesses
    Then I should have 3 correct guesses
    And I should have lost 2 lives

  Scenario: Almost wining a game
    Given I have almost won a game
    When I make an invalid guess
    Then I should not have won the game
    And I should not have lost the game
    And I should have lost 1 more life

  Scenario: Winning a game
    Given I have almost won a game
    When I make a valid guess
    Then I should have won the game
    And I should not have lost the game
    And I should have lost no more lives

  Scenario: Almost losing a game
    Given I have almost lost a game
    When I make a valid guess
    Then I should not have lost the game
    And I should not have won the game
    And I should have lost no more lives

  Scenario: Losing a game
    Given I have almost lost a game
    When I make an invalid guess
    Then I should have lost the game
    And I should not have won the game

  Scenario: Deleting a game
    Given I have a new game
    And I see all the games
    When I click "Destroy" next to a game
    Then I should see a game destroyed
