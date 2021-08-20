load("@ytt:data", "data")
#! dib - v0.25 - 19.aout - add tag in version field
def labels_for_component(comp):
  return {
    "app.kubernetes.io/name": comp,
    "app.kubernetes.io/part-of": data.values.APP,
    #
    "app.kubernetes.io/instance": "k8s-demo-ns-pez-us",
    "app.kubernetes.io/managed-by": "kubectl",
#!    "app.kubernetes.io/version": image_tag_for_component(comp),
  }
end

def annotations_for_component(comp):
  return {
#! dib - v0.25 - 19.aout - add tag in version field
    "version": image_tag_for_component(comp),
    "equipe": "tanzu-se-france",
  }
end

def image_for_component(comp):
  tag = image_tag_for_component(comp)
  sep = ":"
  if tag.startswith("sha256"):
    sep = "@"
  end
  return "{}/k8s-todo-{}{}{}".format(data.values.IMAGE_REPOSITORY, comp, sep, tag)
end

def image_tag_for_component(comp):
  return data.values.IMAGES[comp]
end
