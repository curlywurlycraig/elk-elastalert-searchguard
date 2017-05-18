#!/bin/sh

set -e

# Set the timezone.
if [ "$SET_CONTAINER_TIMEZONE" = "true" ]; then
	setup-timezone -z ${CONTAINER_TIMEZONE} && \
	echo "Container timezone set to: $CONTAINER_TIMEZONE"
else
	echo "Container timezone not modified"
fi

# Force immediate synchronisation of the time and start the time-synchronization service.
# In order to be able to use ntpd in the container, it must be run with the SYS_TIME capability.
# In addition you may want to add the SYS_NICE capability, in order for ntpd to be able to modify its priority.
ntpd -s

echo "Creating Elastalert index in Elasticsearch..."
elastalert-create-index --host ${ELASTICSEARCH_HOST} --port ${ELASTICSEARCH_PORT} --config ${ELASTALERT_CONFIG} --index elastalert_status --old-index ""

echo "Starting Elastalert..."
exec supervisord -c ${ELASTALERT_SUPERVISOR_CONF} -n
