Feature: Playing a game
  As a player
  I want to play a game of hangman

  Scenario: Starting a game
    Given I see the home page
    When I click "New Game"
    Then I should see a new game
    And I should have a guess word of all underscores
    And I should have guessed nothing
    And I should have a score of 10
    And I should not have won the game
    And I should not have lost the game
    And the game should not be finished

  Scenario: Making a valid guess
    Given I have a game with the word hangman
    And I have guessed nothing
    When I make a guess of a
    Then I should have a guessed word of _a___an
    And I should have guessed a
    And I should have a score of 10
    And I should not have won the game
    And I should not have lost the game
    And the game should not be finished

  Scenario: Making an invalid guess
    Given I have a game with the word hangman
    And I have guessed nothing
    When I make a guess of z
    Then I should have a guessed word of _______
    And I should have guessed z
    And I should have a score of 9
    And I should not have won the game
    And I should not have lost the game
    And the game should not be finished

  Scenario: Making multiple guesses
    Given I have a game with the word hangman
    And I have guessed nothing
    When I make a guess of a
    And I make a guess of n
    And I make a guess of z
    And I make a guess of m
    And I make a guess of s
    Then I should have a guessed word of _an_man
    And I should have guessed a, n, z, m, and z
    And I should have a score of 8
    And I should not have won the game
    And I should not have lost the game
    And the game should not be finished

  Scenario: Almost wining a game
    Given I have a game with the word hangman
    And I have guessed a, s, r, n, t, g, and p
    When I guess m
    Then I should not have won the game
    And I should not have lost the game
    And the game should not be finished
    And I should have a guessed word of _angman
    And I should have guessed a, s, r, n, t, g, p, and m
    And I should have a score of 6

  Scenario: Winning a game
    Given I have a game with the word hangman
    And I have guessed a, s, r, n, t, g, p, and m
    When I guess h
    Then I should have won the game
    And I should not have lost the game
    And the game should be finished
    And I should have a guessed word of hangman
    And I should have guessed a, s, r, n, t, g, p, m, and h
    And I should have a score of 6

  Scenario: Almost losing a game
    Given I have a game with the word hangman
    And I have guessed s, r, t, w, n, p, a, e, i, and o
    When I guess u
    Then I should not have lost the game
    And I should not have won the game
    And the game should not be finished
    And I should have a guessed word of _an__an
    And I should have guessed s, r, t, w, n, p, a, e, i, o, and u
    And I should have a score of 1

  Scenario: Losing a game
    Given I have a game with the word hangman
    And I have guessed s, r, t, w, n, p, a, e, i, o, and u
    When I guess y
    Then I should have lost the game
    And I should not have won the game
    And the game should be finished
    And I should have a guessed word of _an__an
    And I should have guessed s, r, t, w, n, p, a, e, i, o, u, and y
    And I should have a score of 0
