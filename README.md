# Example Repo 1

## Structure

This repo is a mono repo of different Terraform projects. Each project in the mono-repo has both a dev and prod environment.

We use the following directory structure:

```
├── modules                 # This contains shared helper modules
│   └── <shared module>
│       └── *.tf
├── <stack>                 # These are stacks that are deployed in different regions
│   └── <region>
│       ├── *.tf
│       ├── dev.tfvars
│       └── prod.tfvars
├── <base stack>            # These are stacks that are not specific to a region
│   ├── *.tf
│   ├── dev.tfvars
│   └── prod.tfvars
├── shared-<region>.tfvars  # This contains region-specific variables, and should be included when running any stacks with region sub-dirs
├── shared-dev.tfvars       # This contains dev-specific variables, and should be included when running any stack in the dev environment
└── shared-prod.tfvars      # This contains prod-specific variables, and should be included when running any stack in the prod environment
```

## Setting up the repo

1. Install Task:
    * If using Mac OS X:
      ```sh
      brew install go-task/tap/go-task
      ```
    * Otherwise, [instructions can be found here](https://taskfile.dev/installation/).

2. Install Infracost
    * If using Mac OS X:
      ```sh
      brew install infracost
      infracost auth login
      ```
    * Otherwise, [instructions can be found here](https://www.infracost.io/docs/#1-install-infracost).

## Running cost estimates

1. Run
    ```sh
    task estimate
    ```

## Running Terraform

To run Terraform plan for a specific stack with a region in the dev environment:
```sh
cd <stack>/<region>
terraform plan -var-file=../../shared-region.tfvars -var-file=../../shared-dev.tfvars -var-file=dev.tfvars
```

To run Terraform plan for a base stack in the dev environment:
```sh
cd <base stack>
terraform plan -var-file=../../shared-dev.tfvars -var-file=dev.tfvars
```
