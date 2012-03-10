@authentication
Feature: User Authentication
  A user should be able to authenticate with an authentication service.

  Scenario Outline: Service Authentication
    Given an authentication service: <authentication service>
    And the service's required parameters: <parameters>
    And the service's accept type is application/json
    When the post callback is issued
    Then the response should not be blank
    And the response body should not be blank
    And the response body should be parseable by JSON
    And the returned JSON should not be blank
    And the returned JSON should have these values: <returned JSON>

  Scenarios: Services
    | authentication service | parameters                                       | returned JSON |
    | developer              | {'name'=>'Roy','email'=>'rwright@example.com'} | ["{\"provider\":\"developer\",\"uid\":\"rwright@example.com\",\"info\":{\"name\":\"Roy\",\"email\":\"rwright@coretrace.com\"},\"credentials\":{},\"extra\":{},\"error\":null,\"error_backtrace\":null}"] |
#    | ldap                    | {} | ["{}"] |
