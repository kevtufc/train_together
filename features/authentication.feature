Feature: Authentication
  In order we know you are who you say you are
  We have an authentication system!

  Scenario: Asked to sign in
    Given I am not logged in
    When I view week 01/01/2017
    Then I am redirected to the login page

  Scenario: Sign in
    Given a user called "Kev" with email "kev@example.com" and password "password"
    When I log in with email "kev@example.com" and password "password"
    Then I am logged in as "Kev"

  Scenario: Sign in
    When I create a user called "Frank Bumblebee" with email "frank@example.com" and password "frankspassword"
    Then a user called "Frank Bumblebee" should exist
