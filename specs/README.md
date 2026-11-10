# Specifications of terraform-helm-kubegreen

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Configuration & Integration

How callers tune the deployment and consume its results.

- **Tool compatibility**: [Declaring supported tool versions](configuration/compatibility/tool-compatibility.feature) (2)
- **Usage examples**: [Surfacing KubeGreen deployment details from the example configuration](configuration/usage-examples/example-deployment-outputs.feature) (1), [Calling the KubeGreen module from a sample configuration](configuration/usage-examples/usage-example.feature) (1)

## Developer Tooling

Local commands and quality gates for maintaining the module.

- **Task commands**: [Running repository task commands](developer-tooling/task-commands/repository-task-commands.feature) (4)

## KubeGreen Installation

Installing the kube-green controller into a Kubernetes cluster as a Helm release.

- **Release deployment**: [Configuring the KubeGreen installation](installation/release-deployment/kubegreen-install-inputs.feature) (4)
