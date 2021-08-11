load("@ytt:data", "data")
#! dib - 11.aout - add tag in version field
def labels_for_component(comp):
  return {
    "app.kubernetes.io/name": comp,
    "app.kubernetes.io/part-of": data.values.APP,
    "app.kubernetes.io/version": image_tag_for_component(comp),
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
