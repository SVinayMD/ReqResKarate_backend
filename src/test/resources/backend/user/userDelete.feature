Feature: User Delete - Service /users/{id} Delete Method
  As an QA Automation engineer
  i want to be able to delete an user
  so i can ensure the proper behavior of the endpoint

  Background: consume service and define preconditions and scripts
    * url url

  Scenario: Validate status 204 when deleting an User

    Given path "users/"+userId
    When method delete
    Then status 204
    And print "succesful"

  Scenario: Validate proper removal of an User registry

    Given path "users/"+userId
    And method delete
    And status 204
    When path "users/"+userId
    And method get
    Then status 404
    And print response
    And print "succesful"