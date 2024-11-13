module ApplicationHelper
  def render_flash
    turbo_stream.prepend 'flash_messages', partial: 'layouts/flash'
  end
end
