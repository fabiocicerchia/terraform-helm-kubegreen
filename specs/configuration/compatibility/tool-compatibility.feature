@domain:configuration @area:compatibility @from:terraform-helm-kubegreen/versions
Feature: Declaring supported tool versions
  Tells operators which Terraform/OpenTofu and Helm provider versions the KubeGreen module works with, so an unsupported toolchain is refused up front instead of failing mid-deployment.

  Background:
    Given the operator's root configuration calls the KubeGreen module

  @id:configuration.compatibility.001 @rule:compatibility.toolchain.minimum-cli-version @inferred @source:versions.tf#terraform
  Scenario Outline: The module refuses Terraform releases older than 1.0
    Given the operator runs <tool> version <cli_version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | tool      | cli_version | outcome                                                                     |
      | Terraform | 0.15.5      | is refused with an unsupported Terraform Core version error naming ">= 1.0" |
      | Terraform | 1.0.0       | proceeds                                                                    |
      | Terraform | 1.9.8       | proceeds                                                                    |
      | OpenTofu  | 1.6.0       | proceeds                                                                    |

  @id:configuration.compatibility.002 @rule:compatibility.toolchain.helm-provider-2-or-later @inferred @source:versions.tf#terraform @questionable
  Scenario Outline: The module installs with any Helm provider from 2.0 onwards
    Given the operator's configuration pins the hashicorp/helm provider to <provider_version>
    When the operator initialises the configuration
    Then provider selection <outcome>

    Examples:
      | provider_version | outcome                                          |
      | 1.3.2            | is refused because no version satisfies ">= 2.0" |
      | 2.17.0           | succeeds                                         |
      | 3.0.2            | succeeds                                         |
