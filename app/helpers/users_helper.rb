# encoding utf-8
module UsersHelper
  # 默认情况下，所有帮助方法文件定义的方法都可以用在任意的视图上，不过为了
  # 方便管理，最好还是归类存放

  # Gravatar的概念首先是在国外的独立WordPress博客中兴起的，当你到任何一个支持Gravatar的网站留言时，
  # 这个网站都就会根据你所提供的Email地址为你显示出匹配的头像。
  # 当然，这个头像，是需要你事先到Gravatar的网站注册并上传的，否则，在这个网站上，就只会显示成一个默认的头像
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
