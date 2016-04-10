Feature: Managing word lists
  As a user
  I want to create, edit, and delete word lists

  Scenario: Creating empty word list
    Given I see all the word lists
    When I click "New Word list"
    And I enter "empty" as Name
    And I click "Create Word list"
    Then I should see a new word list

  Scenario: Creating a word lists with words
    Given I see all the word lists
    When I click "New Word list"
    And I enter "testing" as Name
    And I enter in a word
    And I click "Create Word list"
    Then I should see a new word list
    And I should see 1 word
    And I should see the word

  Scenario: Editing an empty word list
    Given I have a word list with no words
    When I click "Edit"
    And I enter in a word
    And I click "Save"
    Then I should see the word
    And I should see 1 word

  Scenario: Editing a word list
    Given I have a word list with some words
    When I click "Edit"
    And I enter in a word
    And I click "Save"
    Then I should see the word
    And I should see 1 more word

  Scenario: Deleting words from a word list
    Given I have a word list with some words
    When I click "Edit"
    And I click "Delete" next to a word
    And I click "Save"
    Then I should not see the word
    And I should see 1 less word

  Scenario: Deleting a word list
    Given I see all the word lists
    When I click "Destroy" next to a list
    Then I should see all the word lists
    And I should not see the list that I deleted

