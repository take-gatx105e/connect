class RoomChannel < ApplicationCable::Channel
  # サーバーサイドの処理をするファイル
  def subscribed
    # binding.pry
    # サーバサイドからフロントエンドを監視
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # binding.pry
    # フロントエンドからのデータをサーバサイドで受け取る。
    Message.create! content: data['message'], user_id: current_user.id, room_id: params['room']
    # template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    # ActionCable.server.broadcast 'room_channel', template
    # room.js の RoomChannel にdataを渡す(配信する)。
  end
end
