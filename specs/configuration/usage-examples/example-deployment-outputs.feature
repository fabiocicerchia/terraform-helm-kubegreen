@domain:configuration @area:usage-examples @from:examples/outputs
Feature: Surfacing KubeGreen deployment details from the example configuration
  Shows operators who copy the sample root configuration how to read back where KubeGreen was installed, under which release name and at which chart version, so other configuration can consume them.

  Background:
    Given the operator uses the example root configuration that calls the KubeGreen module

  @id:configuration.usage-examples.002 @rule:kubegreen.examples.outputs-expose-deployment-details @inferred @source:examples/outputs.tf#kubegreen_namespace
  Scenario Outline: The example configuration reports KubeGreen's namespace, release name and chart version
    Given the example installs KubeGreen as release "kubegreen" in namespace "kubegreen-system" with no chart version pinned
    When the operator applies the example configuration
    Then the output "<output>" shows <value>
    And the output is described as "<description>"

    Examples:
      | output                  | value                                                    | description                                 |
      | kubegreen_namespace     | "kubegreen-system"                                       | The namespace where KubeGreen is deployed   |
      | kubegreen_release_name  | "kubegreen"                                              | The Helm release name of KubeGreen          |
      | kubegreen_chart_version | the kube-green chart version that was actually installed | The chart version of the deployed KubeGreen |
