Feature: User Creation - Service /users Post Method
  As an QA Automation engineer
  i want to be able to create an user
  so i can ensure the proper behavior of the API

  Background: consume service and define preconditions and scripts
    * url url
    * def userCreateResponse = read("userCreateResponse.json")
    * def random = read("randomData.json")
    * def randomfunct = function(max){ return Math.floor(Math.random() * max) }

  Scenario: Validate status 201 when creating an User

    Given path "users"
    When method post
    Then status 201
    And print response
    And print "succesful"

  Scenario: Validate Response obligatory fields

    Given path "users"
    When method post
    Then status 201
    And match response == userCreateResponse
    And print response
    And print "succesful"


  Scenario: Validate User Creation with additional fields
    * def randomUsername = randomfunct(random.usernames.length)
    * def randomJob = randomfunct(random.jobs.length)
    * def username = random.usernames[randomUsername]
    * def job = random.jobs[randomJob]

    Given path "users"
    And request { "name": "#(username)", "job": "#(job)"}
    When method post
    Then status 201
    And assert response.name == username
    And assert response.job == job
    And match response.id == userCreateResponse.id
    And match response.createdAt == userCreateResponse.createdAt
    And print response
    And print "succesful"

  Scenario Outline: Validate User Creation with additional field using <datatype>

    Given path "users"
    And request { "data": <data>}
    When method post
    Then status 201
    And match response == <expected>
    And print response
    And print "respuesta es de tipo: "+<datatype>
    And print "succesful"

    Examples:
      | data      | datatype | expected                                                 |
      | 'abcd123' | 'string' | { data: '#string', id: '#string', createdAt: '#string' } |
      | 123       | 'number' | { data: '#number', id: '#string', createdAt: '#string' } |
      | null      | 'null'   | { data: '#null', id: '#string', createdAt: '#string' }   |

  Scenario: Validate Field id its an inmutable field

    Given path "users"
    And request { "id": 1324234}
    When method post
    Then status 201
    And def resType = karate.typeOf(response.id)
    And def regType = karate.typeOf(userCreateResponse.id)
    And match karate.typeOf(response.id) == regType
    And print resType+' es igual a '+reqType
    And print response
    And print "succesful"

  Scenario: Validate Field createdAt its an inmutable field

    Given path "users"
    And request { "createdAt": 13136942}
    When method post
    Then status 201
    And def resType = karate.typeOf(response.id)
    And def regtt = karate.typeOf(userCreateResponse.id)
    And match karate.typeOf(response.id) == regtt
    And print resType+' es igual a '+regtt
    And print response
    And print "succesful"
