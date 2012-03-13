@authorization

Feature: User Authorization
  User authorization combines the controller logged_in? with the user rolls to determine if the user is authorized.

  Further when a user is authenticated (logged in), it's roll may be queried with .script? and .admin?.
  a "logged in" state and an "authorized" state.  If the user is not currently authenticated, then these states
  shall return false.

  Scenario Outline: Authorization
  Each request may have an authorization requirement.  This may be: admin only, script or admin, or everyone.
    Given required authorization is: <required authorization>
    And the user logged in state is: <logged_in?>
    And the user authorization for scripts is: <script?>
    And the user authorization for admins is: <admin?>
    When Authorization is checked
    Then Authorization result is: <authorized>

  Scenarios: User Authorization
    | required authorization | logged_in? | script? | admin? | authorized |
    | :everyone              | false      | false   | false  | true       |
    | :everyone              | false      | true    | false  | true       |
    | :everyone              | false      | false   | true   | true       |
    | :everyone              | true       | false   | false  | true       |
    | :everyone              | true       | true    | false  | true       |
    | :everyone              | true       | false   | true   | true       |
    | :script                | false      | false   | false  | false      |
    | :script                | false      | true    | false  | false      |
    | :script                | false      | false   | true   | false      |
    | :script                | true       | false   | false  | false      |
    | :script                | true       | true    | false  | true       |
    | :script                | true       | false   | true   | true       |
    | :admin                 | false      | false   | false  | false      |
    | :admin                 | false      | true    | false  | false      |
    | :admin                 | false      | false   | true   | false      |
    | :admin                 | true       | false   | false  | false      |
    | :admin                 | true       | true    | false  | false      |
    | :admin                 | true       | false   | true   | true       |


