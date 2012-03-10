@restful
Feature: RESTful Routing
  The RESTfulController shall support the eight actions as
  described in http://en.wikipedia.org/wiki/Restful#RESTful_web_services

  Scenario Outline: Expected error conditions
    Given the http method: "<http_method>"
    And the url: "<url>"
    And an Accept type of: "<accept>"
    When the method is invoked
    Then the http response status is: "<status>"
    And the http response Content-Type is: "<content_type>"
    And the response body sans backtrace is: <response_body>

    Scenarios: good
      | http_method | url     | accept           | status | content_type     | response_body                                           |
      | get         | /test   | application/json | 200    | application/json | {'action'=>'list-set',     'args'=>[],    'error'=>nil} |
      | put         | /test   | application/json | 200    | application/json | {'action'=>'replace-set',  'args'=>[],    'error'=>nil} |
      | post        | /test   | application/json | 200    | application/json | {'action'=>'create-set',   'args'=>[],    'error'=>nil} |
      | delete      | /test   | application/json | 200    | application/json | {'action'=>'delete-set',   'args'=>[],    'error'=>nil} |
      | get         | /test/1 | application/json | 200    | application/json | {'action'=>'list-item',    'args'=>['1'], 'error'=>nil} |
      | put         | /test/2 | application/json | 200    | application/json | {'action'=>'replace-item', 'args'=>['2'], 'error'=>nil} |
      | post        | /test/3 | application/json | 200    | application/json | {'action'=>'create-item',  'args'=>['3'], 'error'=>nil} |
      | delete      | /test/4 | application/json | 200    | application/json | {'action'=>'delete-item',  'args'=>['4'], 'error'=>nil} |

    Scenarios: errors
      | http_method | url                | accept           | status | content_type     | response_body                                                                                 |
      | get         | /test/create-set   | application/json | 200    | application/json | {'action'=>'list-item',    'args'=>['create-set'],     'error'=>'Expected integer parameter'} |
      | get         | /test/create-set/1 | application/json | 200    | application/json | {'action'=>'list-item',    'args'=>['create-set','1'], 'error'=>'Expected integer parameter'} |
      | get         | /test/foobar       | application/json | 200    | application/json | {'action'=>'list-item',    'args'=>['foobar'],         'error'=>'Expected integer parameter'} |
      | put         | /test/create-set   | application/json | 200    | application/json | {'action'=>'replace-item', 'args'=>['create-set'],     'error'=>'Expected integer parameter'} |
      | put         | /test/list-set/4   | application/json | 200    | application/json | {'action'=>'replace-item', 'args'=>['list-set','4'],   'error'=>'Expected integer parameter'} |
      | put         | /test/foobar       | application/json | 200    | application/json | {'action'=>'replace-item', 'args'=>['foobar'],         'error'=>'Expected integer parameter'} |
      | post        | /test/list-set     | application/json | 200    | application/json | {'action'=>'create-item',  'args'=>['list-set'],       'error'=>'Expected integer parameter'} |
      | post        | /test/create-set/2 | application/json | 200    | application/json | {'action'=>'create-item',  'args'=>['create-set','2'], 'error'=>'Expected integer parameter'} |
      | post        | /test/foobar       | application/json | 200    | application/json | {'action'=>'create-item',  'args'=>['foobar'],         'error'=>'Expected integer parameter'} |
      | delete      | /test/create-set   | application/json | 200    | application/json | {'action'=>'delete-item',  'args'=>['create-set'],     'error'=>'Expected integer parameter'} |
      | delete      | /test/create-set/3 | application/json | 200    | application/json | {'action'=>'delete-item',  'args'=>['create-set','3'], 'error'=>'Expected integer parameter'} |
      | delete      | /test/foobar       | application/json | 200    | application/json | {'action'=>'delete-item',  'args'=>['foobar'],         'error'=>'Expected integer parameter'} |

