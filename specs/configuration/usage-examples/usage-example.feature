@domain:configuration @area:usage-examples @from:examples/examples
Feature: Calling the KubeGreen module from a sample configuration
  Gives operators a ready-made root configuration that installs kube-green with explicit settings, so they can copy it as a starting point.

  Background:
    Given the operator uses the sample configuration in the examples directory
    And the sample calls the KubeGreen module from the repository root

  @id:configuration.usage-examples.001 @rule:examples.usage.helm-provider-limited-to-2x @inferred @source:examples/main.tf#terraform @questionable
  Scenario: The sample accepts only Helm provider 2.x, though the module allows any version from 2.0
    Given only Helm provider 3.x is available to the operator
    When the operator initialises the sample configuration
    Then provider resolution fails because the sample requires hashicorp/helm "~> 2.0"
    And the module alone would accept that provider version, since it declares ">= 2.0"
