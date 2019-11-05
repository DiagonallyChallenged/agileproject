$(function () {
  $('.piece').draggable({
    snap: '.square',
    revert: 'invalid'
  });

  $('.square').droppable({
    drop: function( event, ui ) {
      const $square = $(event.target);
      const $piece = $(event.toElement);

      const newLocation = {
        x_location: $square.data('x'),
        y_location: $square.data('y'),
        authenticity_token: $('[name="csrf-token"]')[0].content,
      }

      const pieceId = $piece.data('piece-id')

      $.ajax({
        url: '/pieces/' + pieceId,
        method: 'PUT',
        data: newLocation,
        dataType: 'json',
      }).then(function() {
        let currentTurn = $('.current-turn').text();
        console.log(currentTurn);

        if (currentTurn === 'White') {
          $('.current-turn').text('Black');
        } else {
          $('.current-turn').text('White');
        }
      }).catch(function() {
        console.log('Can this revert?')
      });

    }
  });

});