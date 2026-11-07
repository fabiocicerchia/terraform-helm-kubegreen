@domain:developer-tooling @area:task-commands @from:terraform-helm-kubegreen/makefile
Feature: Running repository task commands
  Gives a contributor the same standard make verbs as every repository in the estate, so they can discover, validate and lint the module without reading the Makefile, and every verb either works, says why it does nothing, or fails loudly.

  Background:
    Given Given a contributor has a checkout of the kube-green Terraform module

  @id:developer-tooling.task-commands.001 @rule:tooling.make.default-lists-verbs @inferred @source:Makefile#help
  Scenario: Running make with no verb lists the available verbs
    When When the contributor runs make with no verb
    Then Then each verb is printed with its one-line description
    And And the list includes help, setup, install, lint, format, test, analyze, build and run
    And And the command exits with status 0

  @id:developer-tooling.task-commands.002 @rule:tooling.make.not-applicable-verbs-explain-themselves @inferred @source:Makefile#build
  Scenario Outline: Verbs that do not apply to a Terraform module say why and succeed
    When When the contributor runs make <verb>
    Then Then the message "<message>" is shown
    And And the message "See README > Not applicable." is shown
    And And the command exits with status 0

    Examples:
      | verb  | message                                                                  |
      | build | Nothing to build: this is a Terraform module, consumed from source.      |
      | run   | Nothing to run: a module is called by a root module, never run directly. |

  @id:developer-tooling.task-commands.003 @rule:tooling.make.test-validates-module-and-examples @inferred @source:Makefile#test
  Scenario: The test verb validates both the module and its example without a backend
    Given Given no Terraform backend is configured
    When When the contributor runs make test
    Then Then the module's Terraform configuration is validated
    And And the example root configuration is validated
    And And the command exits non-zero if either fails validation

  @id:developer-tooling.task-commands.004 @rule:tooling.make.analyze-refuses-without-tflint @inferred @source:Makefile#analyze
  Scenario: Static analysis refuses to run when tflint is not installed
    Given Given tflint is not installed on the contributor's machine
    When When the contributor runs make analyze
    Then Then the error "analyze needs tflint: https://github.com/terraform-linters/tflint" is shown
    And And the command exits with status 69
    And And no analysis is reported as passing
