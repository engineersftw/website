$(document).ready(
  $(".thumbnail a").click(function(e){
    e.preventDefault();
    player.loadVideoById($(this).data('video-id'));
    // player.playVideoAt($(this).data('pos'));
  })
);
