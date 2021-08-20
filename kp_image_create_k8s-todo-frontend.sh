kp image create k8s-todo-frontend \
--tag harbor.withtanzu.com/pa-dburkhalter/k8s-todo-frontend \
--local-path /Users/dburkhalter/iena/pivotal/github/k8s-todo-app/frontend  \
--env BP_OCI_DESCRIPTION="k8s-todo-app Application" \
--env 'BP_IMAGE_LABELS=relise="k8s-todo-frontend v0.13.0 - 10.aout.2021"' \
--env BP_OCI_AUTHORS="Tanzu South EMEA" \
--env BP_OCI_TITLE="Spring Boot k8s-todo-frontend" \
--env BP_OCI_DOCUMENTATION="created on 10.aout.2021" \
--env BP_NGINX_VERSION="1.21.0" \
--output yaml --dry-run-with-image-upload  > k8s-todo-frontend_image.yaml