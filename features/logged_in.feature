@logged_in

Feature: Logged in state
  If a user is currently authenticated, then the controller can query if the user is logged in.

  Scenario: Not authenticated
    Given a request where the user is not authenticated
    When an action is executed
    Then logged_in? must be deasserted

  Scenario: Authenticated
    Given An authenticated request
    When an action is executed
    Then logged_in? must be asserted

