# Example Repo 1

## Structure

This repo is a mono repo of different Terraform projects.

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
├── <global stack>          # These are stacks that are global across all regions
│   ├── *.tf
│   ├── dev.tfvars
│   └── prod.tfvars
├── global-<region>.tfvars  # This contains region-specific variables
├── global-dev.tfvars       # This contains dev-specific variables
└── global-prod.tfvars      # This contains prod-specific variables
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
terraform plan -var-file=../../global-region.tfvars -var-file=../../global-dev.tfvars -var-file=dev.tfvars
```

To run Terraform plan for a global stack in the dev environment:
```sh
cd <global stack>
terraform plan -var-file=../../global-dev.tfvars -var-file=dev.tfvars
```



