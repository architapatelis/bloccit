module ApplicationHelper
  # two arguments - first argument is an array of errors, and the second is a block.
  # ''&'' turns the block into a Proc - a block that can be reused like a variable
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << 'has-error' if errors.any?

    # content_tag is a helper method
    # creates the symbol-specified HTML tag with the block contents, and if specified, the options hash
    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
 end
 
end
