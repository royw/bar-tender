@restful
Feature: RESTful Routing
  The RESTfulController shall support the eight actions as
  described in http://en.wikipedia.org/wiki/Restful#RESTful_web_services

  Scenario Outline: RESTful web services
    Given the http method: "<http_method>"
    And the url: "<url>"
    And an Accept type of: "<accept>"
    When the method is invoked
    Then the http response status is: "<status>"
    And the http response Content-Type is: "<content_type>"
    And the response body is: <response_body>

    Scenarios: all
      | http_method | url     | accept           | status | content_type     | response_body                                                                 |
      | get         | /test   | application/json | 200    | application/json | {'action'=>'list-set',     'args'=>[],  'error'=>nil, 'error_backtrace'=>nil} |
      | put         | /test   | application/json | 200    | application/json | {'action'=>'replace-set',  'args'=>[],  'error'=>nil, 'error_backtrace'=>nil} |
      | post        | /test   | application/json | 200    | application/json | {'action'=>'create-set',   'args'=>[],  'error'=>nil, 'error_backtrace'=>nil} |
      | delete      | /test   | application/json | 200    | application/json | {'action'=>'delete-set',   'args'=>[],  'error'=>nil, 'error_backtrace'=>nil} |
      | get         | /test/1 | application/json | 200    | application/json | {'action'=>'list-item',    'args'=>[1], 'error'=>nil, 'error_backtrace'=>nil} |
      | put         | /test/2 | application/json | 200    | application/json | {'action'=>'replace-item', 'args'=>[2], 'error'=>nil, 'error_backtrace'=>nil} |
      | post        | /test/3 | application/json | 200    | application/json | {'action'=>'create-item',  'args'=>[3], 'error'=>nil, 'error_backtrace'=>nil} |
      | delete      | /test/4 | application/json | 200    | application/json | {'action'=>'delete-item',  'args'=>[4], 'error'=>nil, 'error_backtrace'=>nil} |

