#!/bin/bash

set +ex

source /calculate_fpm_workers.sh

# run local services
exec /usr/bin/runsvdir /etc/service
