@tag1
Feature: Add an Item
  As a User 
  I should be able to write gherkin style features
  So that i can test my app

  Background: setup
    Given I am on the main page

  Scenario: open the add item page
    Given I am on the main page
    When I tap the "Add Item" button
    Then I should see the "Add Item" page
