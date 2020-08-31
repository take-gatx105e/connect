document.addEventListener('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create({
    channel: "RoomChannel",
    room: $('#messages').data('room_id')
    }, {
    // クライアントサイドの処理をするファイル
    connected: function() {
      console.log('connected');
      // フロントエンドからサーバサイドを監視
      // Called when the subscription is ready for use on the server
    },
  
    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },
  
    received: function(data) {
      // alert(data)
      // room_channel.rb で broadcast されたdataを受け取る。
      return $('#messages').append(data['message']);
      // return $('#messages').prepend(data['message']);
      // $("#messages").scrollTop($("#messages").last().height());
      // Called when there's incoming data on the websocket for this channel
    },
  
    speak: function(message) {
      return this.perform('speak', {message: message});
      // room_channel.rb の speakメソッドが実行される。
    }
  });
  
  // enterキーを押したら送信に変更。
  // $('#chat-input').on('keypress', function(event) {
  //   if (event.keyCode === 13) {
  //     App.room.speak(event.target.value);
  //     event.target.value = '';
  //     return event.preventDefault();
  //   }
  // });
  
  // ボタンをクリックしたら送信に変更。
  // document.addEventListener('DOMContentLoaded', function() {
    const input = document.getElementById('chat-input');
    const button = document.getElementById('button');
  if (button != null) {
    // nullだったら処理をスルーする。
    button.addEventListener('click', function(event) {
      const content = input.value;
      App.room.speak(content);
      input.value = '';
      return event.preventDefault();
      // 画面遷移を中断する。
      // console.log('aaa');
    });
  }
  // }, false);
});
  