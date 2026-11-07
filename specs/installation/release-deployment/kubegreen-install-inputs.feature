@domain:installation @area:release-deployment @from:terraform-helm-kubegreen/variables
Feature: Configuring the KubeGreen installation
  Lets an operator install kube-green with zero inputs or tailor the release name, namespace, chart version and Helm values, so the module fits existing cluster conventions.

  Background:
    Given the operator applies the KubeGreen module to a Kubernetes cluster

  @id:installation.release-deployment.001 @rule:kubegreen.install.defaults-when-inputs-omitted @inferred @source:variables.tf#release_name
  Scenario: Installing without any inputs uses the kube-green defaults
    Given the operator sets none of the module inputs
    When the operator applies the configuration
    Then a Helm release named "kube-green" is installed
    And the release lives in the "kube-green" namespace
    And the latest published kube-green chart version is installed
    And the chart's own default values are used

  @id:installation.release-deployment.002 @rule:kubegreen.install.custom-release-name-and-namespace @inferred @source:variables.tf#namespace
  Scenario Outline: An operator-chosen release name and namespace are used for the installation
    Given the operator sets the release name to "<release_name>"
    And the operator sets the namespace to "<namespace>"
    When the operator applies the configuration
    Then a Helm release named "<release_name>" is installed in the "<namespace>" namespace
    And the "<namespace>" namespace exists afterwards even if it did not before

    Examples:
      | release_name | namespace      |
      | kube-green   | kube-green     |
      | sleepy-dev   | platform-tools |

  @id:installation.release-deployment.003 @rule:kubegreen.install.chart-version-pinned-or-latest @inferred @source:variables.tf#chart_version
  Scenario Outline: A pinned chart version is installed, and an empty version follows the latest
    Given the operator sets the chart version to "<chart_version>"
    When the operator applies the configuration
    Then the installed kube-green chart version is <installed>

    Examples:
      | chart_version | installed                    |
      |               | the latest published version |
      | 0.7.0         | 0.7.0                        |

  @id:installation.release-deployment.004 @rule:kubegreen.install.values-passed-to-chart @inferred @source:variables.tf#values @questionable
  Scenario Outline: Operator-supplied Helm values customise the kube-green deployment
    Given the operator supplies the Helm values <values>
    When the operator applies the configuration
    Then the kube-green release is deployed with <effect>

    Examples:
      | values                                            | effect                                 |
      | { replicaCount = 2 }                              | 2 controller replicas                  |
      | { resources = { limits = { memory = "256Mi" } } } | a 256Mi memory limit on the controller |
