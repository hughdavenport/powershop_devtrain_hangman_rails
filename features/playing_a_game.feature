Feature: Playing a game
  As a player
  I want to play a game of hangman

  Scenario: Starting a game
    Given I start a new game of hangman
    Then the score should be set
    And the score should be the default
    And the word should be set
    And the word should be the default
