Pusher.logToConsole = true;

var pusher = new Pusher('dc946c831063f1d9fca9', {
  cluster: 'us2',
  encrypted: true
});
var game_channel = pusher.subscribe('game');
game_channel.bind('update',
  function(data) {
    changeTurn(data.turn);
  }
);

var piece_channel = pusher.subscribe('piece');
piece_channel.bind('update',
  function(data) {
    console.log(data);
    movePiece(data);
  }
);


function changeTurn(turn) {
  var color = turn.charAt(0).toUpperCase() + turn.slice(1);
  $('.current-turn').text(color);
}

function movePiece(piece) {
  // var elem = document.querySelectorAll(`[data-piece-id]='${piece.id}'`);
  // elem.parentNode.removeChild(elem);
}