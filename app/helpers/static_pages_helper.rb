module StaticPagesHelper
  def full_title(title)
    if title
      title
    else
      :nothing
    end
  end

end
