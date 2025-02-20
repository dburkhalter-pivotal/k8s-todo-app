# v0.28.1 - 7.septembre
#
# cf https://github.com/paketo-buildpacks/bellsoft-liberica for options
# full - A “large” Ubuntu 18.04 based stack
#
# CI time - maven 
#
# rebuild the .jar / TU's, TI's in CI
# 
make package-backend
#
# Build time - TBS 
#
# size difference between images using full  135 mb to 363 mb
# the builder will combine multiple bp's according what is detected
# java, image-labels, etc
#
kp image patch k8s-todo-backend \
--cluster-builder full \
--blob https://artifactory.withtanzu.com/artifactory/pa-dburkhalter/k8s-todo-backend.jar \
--env BP_JVM_VERSION=16.* \
--env BP_OCI_DESCRIPTION="k8s-todo-app backend Application"  \
--env BP_OCI_AUTHORS="Tanzu-South-EMEA-se-team"  \
--env BP_OCI_TITLE="k8s-todo-backend" \
--env BP_OCI_SOURCE="https://github.com/dburkhalter-pivotal/k8s-todo-app.git" \
--env BP_OCI_DOCUMENTATION="updated on 2021-09-07" \
--env BP_OCI_VERSION="v0.28.1-2021-09-07"  \
--env 'BP_IMAGE_LABELS=relise="k8s-todo-backend-v0.28.1-2021-09-07" io.packeto.maintainer="platform-team" maintainer="product-team"' \
--env JBP_LOG_LEVEL=debug \
--env BP_DEBUG_ENABLED=true  \
--env BPL_DEBUG_ENABLED=true  \
--env BPE_OVERRIDE_BPL_JVM_THREAD_COUNT=150 \
--env BP_JMX_ENABLED=true \
--env BPE_DELIM_JAVA_TOOL_OPTIONS=" "  \
--env BPE_PREPEND_JAVA_TOOL_OPTIONS=" -Xss512k "  \
--env BPE_APPEND_JAVA_TOOL_OPTIONS=" -XX:+UseZGC -XX:+UseContainerSupport -Duser.timezone=CET -DRELISE=k8s-todo-backend_v0.28.1-2021-09-07 -Dspring.devtools.restart.enabled=true -XX:MaxDirectMemorySize=64M -XX:+UnlockExperimentalVMOptions " \
--env BPL_JVM_HEAD_ROOM=15 \
--env BPL_SPRING_CLOUD_BINDINGS_ENABLED=y \
--output yaml --dry-run-with-image-upload > k8s-todo-backend_image.yaml
# 
# CD time - 
#
kubectl apply -f k8s-todo-backend_image.yaml
#
# shows the origine of the jar
# Source:    Blob
# Url:       https://artifactory.withtanzu.com/artifactory/pa-dburkhalter/k8s-todo-backend.jar
#
# get all BP's that participate
#
kp build status k8s-todo-backend
#
kp build logs k8s-todo-backend
#
# kp image list --filter latest-reason=config,trigger
# kp image list --filter latest-reason=trigger
# kp image list --filter ready=true
#
# 
pack inspect-image harbor.withtanzu.com/pa-dburkhalter/k8s-todo-backend:latest --bom | jq '.remote[] | select(.name=="jre") | .metadata.version, .metadata.uri, .metadata.stacks'
#
# docker pull harbor.withtanzu.com/pa-dburkhalter/k8s-todo-backend:latest
# docker inspect harbor.withtanzu.com/pa-dburkhalter/k8s-todo-backend:latest | jq '.[].Config.Labels["org.opencontainers.image.description"]'
#
# ytt -f config -f config-env/dev | kubectl apply -f -
#
# kp image trigger k8s-todo-backend