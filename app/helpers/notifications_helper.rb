module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @visited = notification.visited
    @comment = nil
    @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "follow" then
      tag.a(notification.visitor.name, href: user_path(@visitor)) + "があなたをフォローしました。"
    when "like" then
      tag.a(notification.visitor.name, href: user_path(@visitor)) + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id)) + "に「食べたい！」を押しました。"
    when "comment" then
      @comment = Comment.find_by(id: @visitor_comment)&.content
      tag.a(@visitor.name, href: user_path(@visitor)) + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id)) + "にコメントしました。"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
