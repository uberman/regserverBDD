Feature: Verify the reg server works

  Scenario Outline: when a new user registers a device, all JSON is correct
    Given a new user registers a device
    When the reg server responds
    Then user should get a <postalcode>

  Examples:
  |postalcode      |
  |48104          |