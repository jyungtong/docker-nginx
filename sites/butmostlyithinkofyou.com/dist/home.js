function animateCover(){
  // CONFIGURATION VARIABLES
  var radius=1;

  var canvas_w_modifier = 1;
  var canvas_h_modifier = 0.7;
  var cover_responsive_modifier = 300;

  var min_width = 1100;
  var max_width = 710;
  // =============================

  var canvas = document.getElementById("canvas");
  var ctx = null;
  var $canvas = null;
  var cw = 0;
  var ch = 0;

  var w = Math.max(document.documentElement.clientWidth, 
                    window.innerWidth || 0) * canvas_w_modifier;
  var h = Math.max(document.documentElement.clientHeight, 
                    window.innerHeight || 0) * canvas_h_modifier;

  var cx = w * 0.35;
  var cy = h * 0.8;

  // fade in direction
  // true to right, false to left
  var fade_direction = true; 
  var fade_speed = 0.5;

  if(canvas && canvas.getContext) {
      ctx = canvas.getContext("2d");
      // background
      ctx.fillStyle = "#fff";
      ctx.fillRect(0, 0, w, h);
      $canvas = $("#canvas");
      canvas.width = w;
      canvas.height = h;
  }


  var img = new Image();
  img.src= "/assets/img/cover_illustration.jpg";

  img.onload = function(){
      requestAnimationFrame(animate);
  };


  function draw(){
      canvas.width = w;
      canvas.height = h;
      ctx.clearRect(0, 0, w, h);
      if (w < min_width) {
        ctx.drawImage(img, 
            (w - min_width + getCoverResponsiveModifier()), 0, 
            img.width * (h/img.height), h
          );  
      } else {
        ctx.drawImage(img, 
          0, 0, 
          w, img.height * (w/img.width));  
      }
      ctx.beginPath();
      ctx.strokeStyle = "transparent";
      ctx.rect(0, 0, w, h);

      // create radiant gradient
      var grdRadiant = ctx.createRadialGradient(cx,cy,radius,cx,cy,radius*5);
      grdRadiant.addColorStop(0,"rgba(255,255,255,0)");
      grdRadiant.addColorStop(1,"rgba(255,255,255,1)");
      ctx.fillStyle = grdRadiant;
      ctx.fill();
      ctx.stroke();
      ctx.closePath();
  }

  function animate(time) {
    requestAnimationFrame(animate);
    if(radius > h * 0.4) {
      fade_direction = false;
      fade_speed = 0.25;
    }

    if(radius < h * 0.25) {
      fade_direction = true;
    }

    if(fade_direction) {
      radius += fade_speed;
    } else {
      radius -= fade_speed;
    }

    draw();

  }

  function getCoverResponsiveModifier() {
    if (w > max_width) {
      return 0;
    } else {
      cover_responsive_modifier = max_width - w;
      return cover_responsive_modifier;
    }
  }

  $(window).resize(function() {
    w = Math.max(document.documentElement.clientWidth, 
                      window.innerWidth || 0) * canvas_w_modifier;
    h = Math.max(document.documentElement.clientHeight, 
                      window.innerHeight || 0) * canvas_h_modifier;
    draw();
  });
}
