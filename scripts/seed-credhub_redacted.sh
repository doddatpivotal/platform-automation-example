#!/bin/bash -e

credhub api https://104.196.101.207:8844 --ca-cert <(bosh int generated/concourse/concourse-gen-vars.yml --path /atc_tls/ca)
export CREDHUB_PASSWORD=$(bosh int generated/concourse/concourse-gen-vars.yml --path /uaa-users-admin)
credhub login -u admin -p "$CREDHUB_PASSWORD"

# Concourse main team credentials
credhub set -t value -n '/concourse/main/s3_access_key_id' -v 'REDACTED'
credhub set -t value -n '/concourse/main/s3_secret_access_key' -v 'REDACTED'
credhub set -t value -n '/concourse/main/pivnet_token' -v 'REDACTED'
credhub set -t rsa -n '/concourse/main/platform_automation_example_git_repo' -p ~/.ssh/git_rsa
credhub set -t rsa -n '/concourse/main/platform_automation_example_locks_git_repo' -p ~/.ssh/git_rsa
credhub set -t certificate -n '/concourse/main/credhub_ca_cert' -c <(bosh int ./generated/concourse/concourse-gen-vars.yml --path /atc_tls/ca)
credhub set -t value -n '/concourse/main/credhub_secret' -v $(bosh int ./generated/concourse/concourse-gen-vars.yml --path /uaa-users-admin)
credhub set -t value -n '/concourse/main/concourse_to_credhub_secret' -v $(bosh int ./generated/concourse/concourse-gen-vars.yml --path /concourse_to_credhub_secret)

# Platform Automation credentials for the lab foundation
credhub set -t value -n '/lab-foundation/opsman_username' -v 'admin'
credhub set -t value -n '/lab-foundation/opsman_password' -v 'REDACTED'
credhub set -t ssh -n '/lab-foundation/opsman_ssh' -u ./generated/opsman/pcf-aws-ops-manager-key.pub -p ./generated/opsman/pcf-aws-ops-manager-key.pem
credhub set -t value -n '/lab-foundation/pivnet_token' -v 'REDACTED'
credhub set -t value -n '/lab-foundation/aws_key_id' -v 'REDACTED'
credhub set -t value -n '/lab-foundation/aws_key_secret' -v 'REDACTED'
credhub set -t value -n '/lab-foundation/uaa_ldap_password' -v 'REDACTED'
credhub set -t value -n '/lab-foundation/harbor-container-registry/admin_password' -v 'REDACTED'
credhub set -t certificate -n '/lab-foundation/harbor-container-registry/server_cert_key' -c ./generated/harbor/key.certificate -p ./generated/harbor/key.private-key
credhub set -t certificate -n '/lab-foundation/pivotal-container-service/pks_tls' -c ./generated/pks/pks_tls.certificate -p ./generated/pks/pks_tls.private-key
