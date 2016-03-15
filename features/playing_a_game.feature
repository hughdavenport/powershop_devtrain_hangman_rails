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
    And I have not won the game
    And I have not lost the game
    And I have not finished the game

  Scenario: Starting a game with a set word
    Given I start a new game of hangman with starting word of testing
    Then the word should be the same as the argument

  Scenario: Starting a game with a set score
    Given I start a new game of hangman with starting score of 1
    Then the score should be the same as the argument
