cd ./deploy

# ENV Variables that are used in the platform-service-deploy.sh script
export ECS_CLUSTER=$ECS_CLUSTER_STG
export ECS_SERVICE=$ECS_SERVICE_STG
export SERVICE_CONTAINER_NAME=$ECS_SERVICE_STG
export CONTAINER_TAG=${CIRCLE_BRANCH}-${CIRCLE_BUILD_NUM}
export DATADOG_DASHBOARD_UPDATE_FILENAME=${SERVICE_NAME}.json

export POLL_DEPLOYMENT_STATUS="false"

#download latest deploy script
aws s3 cp "s3://flipp-platform-"$WISHABI_ENVIRONMENT"/deploy/platform-service-deploy.sh" platform-service-deploy.sh
chmod +x platform-service-deploy.sh
#Execute the deployment Scripts
./platform-service-deploy.sh "$@"
