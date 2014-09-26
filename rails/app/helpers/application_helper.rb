module ApplicationHelper

  def gravatar_icon(email, size = nil)
    if email.present?
      size = 40 if size.nil? || size <= 0

      gravatar_url = "http://www.gravatar.com/avatar/#{hash}?s=%{size}&d=identicon"
      sprintf gravatar_url,
        hash: Digest::MD5.hexdigest(email.strip.downcase),
        size: size,
        email: email.strip
    end
  end



end
