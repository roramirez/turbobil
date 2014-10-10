class GravatarService
  #idea from GitLab
  def execute(email, size = nil)
    if email.present?
      size = 40 if size.nil? || size <= 0
      sprintf gravatar_url,
        hash: Digest::MD5.hexdigest(email.strip.downcase),
        size: size,
        email: email.strip
    end
  end

  def gravatar_url
    url = "http://www.gravatar.com/avatar/%{hash}&s=%{size}&d=mm"
  end
end
