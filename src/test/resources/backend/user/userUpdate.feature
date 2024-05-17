Feature: User Update - Service /users/{id} Update Method
  As an QA Automation engineer
  i want to be able to update an user
  so i can ensure the proper behavior of the endpoint

  Background: consume service and define preconditions and scripts
    * url url
    * def userUpdateResponse = read("userUpdateResponse.json")
    * def random = read("randomData.json")
    * def randomfunct = function(max){ return Math.floor(Math.random() * max) }

  Scenario: Validate status 200 when updating an User

    Given path "users/"+userId
    When method put
    Then status 200
    And print response
    And print "succesful"

  Scenario: Validate response structure when Updating an user

    Given path "users/"+userId
    When method put
    Then status 200
    And match response == userUpdateResponse
    And print response
    And print "succesful"

  Scenario: Validate response structure when Updating an user with additional data
    * def randomUsername = randomfunct(random.usernames.length)
    * def randomJob = randomfunct(random.jobs.length)
    * def username = random.usernames[randomUsername]
    * def job = random.jobs[randomJob]

    Given path "users/"+userId
    And request { "name": "#(username)", "job": "#(job)"}
    When method put
    Then status 200
    And assert response.name == username
    And assert response.job == job
    And match response.updatedAt == userUpdateResponse.updatedAt
    And print response
    And print "succesful"

  Scenario: Validate updatedAt is an inmutable property
    * def randomUsername = randomfunct(random.usernames.length)
    * def randomJob = randomfunct(random.jobs.length)
    * def username = random.usernames[randomUsername]
    * def job = random.jobs[randomJob]

    Given path "users/"+userId
    And request { "name": "#(username)", "job": "#(job)", "updatedAt": 12345}
    When method put
    Then status 200
    And match response.updatedAt != 12345
    And print response
    And print "succesful"