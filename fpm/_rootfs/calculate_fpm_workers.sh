#!/bin/bash

set +ex

function calculate_workers() {
    if [ -z "$MAX_CHILDREN" ]; then
        # calculate the proper number of workers that should be configured in the needed pool
        total_memory=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        operational_memory=$((70*$total_memory/100))
        worker_consumption=80000
        fpm_max_workers=$((operational_memory/$worker_consumption))
        # if the number of total workers is greater than 8, export the numbers. Otherwise set the defaults
        # to 24 just in case
        if [ "$fpm_max_workers" -gt 8 ]; then
            export MAX_CHILDREN=$fpm_max_workers
        else
            export MAX_CHILDREN=24
        fi
        export MIN_SPARE_SERVERS=$(($MAX_CHILDREN/8))
        export MAX_SPARE_SERVERS=$(($MAX_CHILDREN/2))
        export START_SERVERS=$(($MAX_CHILDREN/4))
        # end calculation
    fi
}

# calculate workers
calculate_workers

# generate the configurations as specified in consul-template
consul-template -config "/etc/consul-template/consul-template.cfg" -once
