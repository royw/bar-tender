@user_rolls
Feature: User rolls and states
  Each user shall have a roll assigned when they are first logged in based on the authentication method
  used (ldap will set roll to admin, certificate or password will set roll to script, default roll is unknown).


  Scenario Outline: User rolls
    Given a user with a roll set to: <user roll>
    When the user is queried
    Then the script? method should return: <script?>
    And the admin? method should return: <admin?>

  Scenarios: Possible rolls and the query results
    | user roll | script? | admin? |
    | unknown   | false   | false  |
    | script    | true    | false  |
    | admin     | false   | true   |

