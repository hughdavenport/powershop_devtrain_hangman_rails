Feature: Playing a game
  As a player
  I want to play a game of hangman

  Scenario: Starting a game
    Given I start a new game of hangman
    Then the score should be set
    And the score should be the default
    And the word should be set
    And the word should be the default
    And the word guessed so far should be empty
    And I should not have won the game
    And I should not have lost the game
    And I should not have finished the game

  Scenario: Starting a game with a set word
    Given I start a new game of hangman with starting word of testing
    Then the word should be the same as the argument

  Scenario: Starting a game with a set score
    Given I start a new game of hangman with starting score of 1
    Then the score should be the same as the argument

  Scenario: When I lose a game
    Given I start a new game of hangman with starting score of 1
    When I make an incorrect guess
    Then I should not have won the game
    And I should have lost the game
    And I should have finished the game
    And the score should be 0

  Scenario: When I haven't lost the game
    Given I start a new game of hangman with starting score of 1
    When I make a correct guess
    Then I should not have won the game
    And I should not have lost the game
    And I should not have finished the game
    And the score should be 1
