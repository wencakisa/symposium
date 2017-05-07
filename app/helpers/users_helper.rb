module UsersHelper
  def gravatar_for(user, size: 350, responsive: true, centered: false)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

    img_class = 'img-circle'
    img_class << ' img-responsive' if responsive
    img_class << ' img-centered' if centered

    image_tag(gravatar_url, alt: user.name, class: img_class)
  end
end
