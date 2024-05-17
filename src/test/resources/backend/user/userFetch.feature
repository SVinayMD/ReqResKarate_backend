Feature: User Fetch - Service /users/{id} Get Method
  As an QA Automation engineer
  i want to be able to fetch an user
  so i can ensure the proper behavior of the endpoint

  Background: consume service and define preconditions and scripts
    * url url
    * def userFetchResponse = read("userFetchResponse.json")

  Scenario: Validate status 200 when fetching an existent user

    Given path "users/"+userId
    When method get
    Then status 200
    And print response
    And print "succesful"

  Scenario: Validate status 404 when fetching a non existing user

    Given path "users/"+nonExistingId
    When method get
    Then status 404
    And print response
    And print "succesful"

  Scenario: Validate response structure when fetching an user

    Given path "users/"+userId
    When method get
    Then status 200
    And match response == userFetchResponse.singleFetch
    And print response
    And print "succesful"