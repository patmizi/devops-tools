#!/usr/bin/env bash

function delete_lbaas() {
    # Set the lb id
    LB_ID="$1"

    # delete the lb and all sub components.
    LB_DATA=$(neutron --os-user-domain-name Default lbaas-loadbalancer-show ${LB_ID} --format yaml)
    LB_LISTENERS_ID=$(echo -e "$LB_DATA" | awk -F'"' '/listeners/ {print $4}')
    LB_POOL_ID=$(echo -e "$LB_DATA" | awk -F'"' '/pools/ {print $4}')
    LB_HEALTH_ID=$(neutron --os-user-domain-name Default lbaas-pool-show ${LB_POOL_ID} | awk '/healthmonitor_id/ {print $4}')
    neutron --os-user-domain-name Default lbaas-listener-delete "${LB_LISTENERS_ID}"
    neutron --os-user-domain-name Default lbaas-healthmonitor-delete "${LB_HEALTH_ID}"
    neutron --os-user-domain-name Default lbaas-pool-delete "${LB_POOL_ID}"
    neutron --os-user-domain-name Default lbaas-loadbalancer-delete "${LB_ID}"
}

function main() {
    delete_lbaas $1
}

main $@