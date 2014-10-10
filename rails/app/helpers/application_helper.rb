module ApplicationHelper

  def avatar_icon(email, size = nil)
    gravatar_icon(email, size)
  end

  def gravatar_icon(email, size = nil)
    GravatarService.new.execute(email, size) || default_avatar
  end

  def default_avatar
    image_path('no_avatar.png')
  end

end
