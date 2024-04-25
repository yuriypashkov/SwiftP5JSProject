//
//  Constants.swift
//  WebViewTest
//
//  Created by Yuriy Pashkov on 19.04.2024.
//

import Foundation

// MARK: - JS-code for testing in WKWebView
final class Constants {
    // <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.4.0/p5.js"></script>
    // <script src="sketchLetters.js"></script>
    // <script src="CCapture.all.min.js"></script>
    // <html lang="en">
    // <meta name="viewport" content="width=device-width, initial-scale=1.0">
    static let htmlHeader = """
    <!DOCTYPE html>
    
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>drag the sun with mouse and press somewhere to do something and also pull it around</title>
      <script src="p5.js"></script>
"""
    
    static let sketchGreen = "<script src='sketchGreen.js'></script>"
    static let sketchRed = "<script src='sketchRed.js'></script>"
    
    static let htmlFooter = """
    </head>
    <body>
    </body>
    </html>
"""
    
    // sketch example from Alex
    static let sketchJSFirst = """
    let n = 500;
    let maxLength = 2000;
    let numSegments = 10;
    let mpress = false;
    let pushradius = 0.0;
    let x1;
    let y1;
    let pushx;
    let pushy;

    function setup() {
      createCanvas(256, 256);
      background(250);
      stroke(0);
      x1 = width / 2;
      y1 = height / 2;

    }

    function draw() {
      //resizeCanvas(windowWidth, windowHeight);
      background(100, 200, 100);
      stroke(255);
      let angleStep = TWO_PI / n;

      if (mouseIsPressed && mouseButton === LEFT) {
        let d1 = sqrt(pow(x1-mouseX,2)+pow(y1-mouseY,2));
        if(d1<50){
          x1 = mouseX;
          y1 = mouseY;
        } else {

          pushradius = min(width*10 , pushradius + random(166));
          pushx = mouseX;
          pushy = mouseY;
        }
      }
      else{
        pushradius = max(0,pushradius-random(23));
      }
      let aa = 0.01;
      let sina = sin(aa);
      let cosa = cos(aa);
      let xx = cosa * (x1 - width / 2) - sina * (y1 - height / 2) + width / 2;
      let yy = sina * (x1 - width / 2) + cosa * (y1 - height / 2) + width / 2;
      x1 = xx;
      y1 = yy;

      maxLength = max(width, height) - borderdist(x1, y1) + 100;

      if (pushradius > 0.0) {
        for (let i = 0; i < 100; i++) {
          stroke(random(66, 120));
          fill(0);
          circle(pushx, pushy, random(pushradius / 8));
        }
      }

      for (let angle = 0; angle < TWO_PI; angle += angleStep) {
        stroke(255);
        let x2 = x1 + cos(angle) * 1;
        let y2 = y1 + sin(angle) * 1;

        let segmentLength = max(width,height)/50;
        let dx = (x2 - x1) * segmentLength;
        let dy = (y2 - y1) * segmentLength;
        let xprev = x1;
        let yprev = y1;

        for (let i = 0; i < 100; i++) {
          let ddx = dx;
          let ddy = dy;
          if (pushradius > 0.00001) {
            let xf = (xprev - pushx) / pushradius;
            let yf = (yprev - pushy) / pushradius;
            let d = sqrt(xf * xf + yf * yf);
            d = d * d * d * 500;
            ddx -= xf / d;
            ddy -= yf / d;
          }
          let ax = xprev;
          let ay = yprev;
          let bx = ax + ddx;
          let by = ay + ddy;
          xprev = bx;
          yprev = by;
          dx = ddx;
          dy = ddy;
          line(ax, ay, bx, by);
          if (bx > width || by > height || bx < 0 || by < 0) {
            break;
          }
        }
      }
    stroke(0);
    //text(""+pushradius,12,12);
    
    noLoop();
    //save("myImage.png");
    }

    function borderdist(x, y) {
      let dx = min(abs(x - 0), abs(x - width));
      let dy = min(abs(y - 0), abs(y - height));
      return min(dx, dy);
    }
"""
    
    // sketch with export first 60 frames, into Documents folder, jpg-format
    static let sketchJSAnimation = """
    function setup() {
      createCanvas(710, 400, WEBGL);
      frameRate(5);
    }

    function draw() {
      background(250);
      rotateY(frameCount * 0.01);

      for (let j = 0; j < 5; j++) {
        push();
        for (let i = 0; i < 80; i++) {
          translate(
            sin(frameCount * 0.001 + j) * 100,
            sin(frameCount * 0.001 + j) * 100,
            i * 0.1
          );
          rotateZ(frameCount * 0.002);
          push();
          sphere(8, 6, 4);
          pop();
        }
        pop();
      }
    
      //save( "myproject-frame-" + frameCount + ".jpg")
      if(frameCount === 60){
        noLoop();
      }
    }

"""
    
    
    static let sketchVideoCapture = """
//const capturer = new CCapture({
//    frameRate: 15,
//    format: "webm",
//    name: "movie",
//    quality: 100,
//    verbose: true,
//});

var capturer = new CCapture({
  format: 'webm',
  name: 'movie',
  frameRate: 15,
});

let p5canvas;

function setup() {
  p5canvas = createCanvas(300, 400, WEBGL);
  frameRate(15);
}

function draw() {
  if (frameCount === 1) {
     capturer.start();
  }
    
  background(250);
  rotateY(frameCount * 0.01);

  for (let j = 0; j < 5; j++) {
    push();
    for (let i = 0; i < 80; i++) {
      translate(
        sin(frameCount * 0.001 + j) * 100,
        sin(frameCount * 0.001 + j) * 100,
        i * 0.1
      );
      rotateZ(frameCount * 0.002);
      push();
      sphere(8, 6, 4);
      pop();
    }
    pop();
    
  }

    capturer.capture(p5canvas);

    if (frameCount === 60) {
        noLoop();
        capturer.stop();
        capturer.save();
    }
    
}
"""
    
    
    static let sketchCapturingSecond = """
const letters = ["A", "B", "C", "D", "E"];

var capturer = new CCapture({ format: 'webm', name: 'movie', framerate: 15} );

function setup() {
  createCanvas(360, 360);
  frameRate(15);
}

function draw() {
    if (frameCount === 1) capturer.start();
    
    background(20);
    
    for (let y = 0; y <= height; y += 40) {
        for (let x = 0; x <= width; x += 40) {
            push();
            translate(x,y);
            fill(random(255), random(255), random(255), random(255));
            text(random(letters), 0, 0);
            pop();
        }
    }
    
    capturer.capture(canvas);

    if (frameCount === 60) {
        noLoop();
        capturer.stop();
        capturer.save();
    }
}
"""
}
