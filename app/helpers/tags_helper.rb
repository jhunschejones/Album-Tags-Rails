module TagsHelper
    # Allow toggling searched params, preventing the user from searching
  # duplicate tags or removing the last searched tag
  def toggle_searched_tags(new_tag, params)
    previous_tags = params["tags"]

    tag_params_string =
      if previous_tags.include?(new_tag) && previous_tags.length == 1
        previous_tags.map { |tag| "&tags[]=#{tag}" }
      elsif previous_tags.include?(new_tag)
        previous_tags.map { |tag| tag == new_tag ? nil : "&tags[]=#{tag}" }.compact
      else
        previous_tags.map { |tag| "&tags[]=#{tag}" }.push("&tags[]=#{new_tag}")
      end
    tag_params_string.unshift("?").join()
  end
end
