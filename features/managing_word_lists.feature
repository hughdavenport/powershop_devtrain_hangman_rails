Feature: Managing word lists
  As a user
  I want to create, edit, and delete word lists

  Scenario: Creating empty word list
    Given I see all the word lists
    When I click "New Word List"
    And I enter "empty" as Name
    And I click "Create Word List"
    Then I should see a new word list

  Scenario: Editing a word list name
    Given I have a word list with no words
    When I click "Edit"
    And I enter "another name" as Name
    And I click "Update Word List"
    Then I should see "another name"

  Scenario: Adding words to an empty word list
    Given I have a word list with no words
    When I add a word
    Then I should see the word
    And I should see 1 word

  Scenario: Adding words to a word list
    Given I have a word list with some words
    When I add a word
    Then I should see the word
    And I should see 1 more word

  Scenario: Deleting words from a word list
    Given I have a word list with some words
    When I delete a word
    Then I should see a word destroyed
    And I should see 1 less word

  Scenario: Deleting a word list
    Given I have a word list with some words
    And I see all the word lists
    When I click "Destroy" next to a list
    Then I should see a word list destroyed
