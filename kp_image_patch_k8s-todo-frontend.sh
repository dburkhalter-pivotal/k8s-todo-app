# v0.30.1 - 2021-09-01
# 
# rfu: --blob https://artifactory.withtanzu.com/artifactory/pa-dburkhalter/k8s-todo-backend.jar \
#
# tanzu-buildpacks/nginx    0.2.0 
# Nginx Server version (using buildpack.toml): 1.19.9
#
# rfu kp clusterstore add default -b paketobuildpacks/nginx:0.3.2
# --env BP_NGINX_VERSION="1.21.0" \
kp image patch k8s-todo-frontend \
--cluster-builder default \
--local-path /Users/dburkhalter/iena/pivotal/github/k8s-todo-app/frontend  \
--env BP_NGINX_VERSION="1.21.2" \
--env BP_OCI_DESCRIPTION="k8s-todo-app frontend Application" \
--env BP_OCI_AUTHORS="Tanzu-South-EMEA" \
--env BP_OCI_TITLE="Vue.js k8s-todo-frontend" \
--env BP_OCI_DOCUMENTATION="updated on 2021-09-01-09:55" \
--env BP_OCI_SOURCE="https://github.com/dburkhalter-pivotal/k8s-todo-app.git" \
--env BP_OCI_VERSION="v0.30.1 - 2021-09-01"  \
--env 'BP_IMAGE_LABELS=io.packeto.example="Adding our Custom Labels" relise="k8s-todo-frontend-v0.30.1-2021-09-01" io.packeto.maintainer="semea-team"' \
--output yaml --dry-run-with-image-upload  > k8s-todo-frontend_image.yaml
#
# kubectl describe image k8s-todo-backend
#
kubectl apply -f k8s-todo-frontend_image.yaml
#
kp build logs  k8s-todo-frontend | tee k8s-todo-frontend_image_build.output
#
kp image status k8s-todo-frontend
#
# docker inspect harbor.withtanzu.com/pa-dburkhalter/k8s-todo-backend:b13.20210825.122744 | jq '.[].Config.Labels["org.opencontainers.image.description"]'
#
# pack inspect-image harbor.withtanzu.com/pa-dburkhalter/k8s-todo-frontend:latest --bom
#
# ytt -f config -f config-env/dev | kubectl apply -f -