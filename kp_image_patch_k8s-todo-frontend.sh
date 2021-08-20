# v0.23 - 19 aout
kp image patch k8s-todo-frontend \
--local-path /Users/dburkhalter/iena/pivotal/github/k8s-todo-app/frontend  \
--env BP_OCI_DESCRIPTION="k8s-todo-app Application" \
--env 'BP_IMAGE_LABELS=relise="k8s-todo-frontend v0.23.2 - 19.aout.2021"' \
--env BP_OCI_AUTHORS="Tanzu-South-EMEA" \
--env BP_OCI_TITLE="Spring Boot k8s-todo-frontend" \
--env BP_OCI_DOCUMENTATION="updated on 2021-08-19-09:68" \
--env BP_NGINX_VERSION="1.21.0" \
--output yaml --dry-run-with-image-upload  > k8s-todo-frontend_image.yaml
#
# kubectl describe image k8s-todo-backend
#
kubectl apply -f k8s-todo-frontend_image.yaml
#
kp build logs  k8s-todo-frontend | tee k8s-todo-frontend_image_build.output
#
kp image status k8s-todo-backend