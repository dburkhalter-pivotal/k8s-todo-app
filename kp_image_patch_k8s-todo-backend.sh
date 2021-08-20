# v0.25.0 - 19.aout
#
# cf https://github.com/paketo-buildpacks/bellsoft-liberica for options
# full - A “large” Ubuntu 18.04 based stack
kp image patch k8s-todo-backend  \
--cluster-builder full \
--blob https://artifactory.withtanzu.com/artifactory/pa-dburkhalter/k8s-todo-backend.jar \
--env BP_JVM_VERSION=16.* \
--env BP_OCI_DESCRIPTION="k8s-todo-app backend Application"  \
--env BP_OCI_AUTHORS="Tanzu-South-EMEA-se-team"  \
--env BP_OCI_TITLE="k8s-todo-backend" \
--env BP_OCI_SOURCE="https://github.com/dburkhalter-pivotal/k8s-todo-app.git" \
--env BP_OCI_DOCUMENTATION="updated on 2021-08-19" \
--env 'BP_IMAGE_LABELS=relise="k8s-todo-backend-v0.25.0-2021-08-19" io.packeto.maintainer="myself"' \
--env JBP_LOG_LEVEL=debug \
--env BP_DEBUG_ENABLED=true  \
--env BPL_DEBUG_ENABLED=true  \
--env BPE_OVERRIDE_BPL_JVM_THREAD_COUNT=150 \
--env BP_JMX_ENABLED=true \
--env BPE_DELIM_JAVA_TOOL_OPTIONS=" "  \
--env BPE_PREPEND_JAVA_TOOL_OPTIONS=" -Xss512k -XX:+PrintFlagsFinal "  \
--env BPE_APPEND_JAVA_TOOL_OPTIONS=" -XX:+UseContainerSupport -Duser.timezone=CET -DRELISE=k8s-todo-backend_2021-08-19_v0.23.0 -Dspring.devtools.restart.enabled=true -XX:MaxDirectMemorySize=64M -XX:+UnlockExperimentalVMOptions " \
--env BPL_JVM_HEAD_ROOM=15 \
--env BPL_SPRING_CLOUD_BINDINGS_ENABLED=y \
--output yaml --dry-run-with-image-upload > k8s-todo-backend_image.yaml
# 
kubectl apply -f k8s-todo-backend_image.yaml
#
# shows the origine of the jar
# Source:    Blob
# Url:       https://artifactory.withtanzu.com/artifactory/pa-dburkhalter/k8s-todo-backend.jar
#
kp build status k8s-todo-backend
#
kp  build logs k8s-todo-backend