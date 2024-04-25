const letters = ["A", "B", "C", "D", "E"];

function setup() {
  createCanvas(360, 360);
  frameRate(5);
}

function draw() {
    
    background(255, 0, 0);
    
    for (let y = 0; y <= height; y += 40) {
        for (let x = 0; x <= width; x += 40) {
            push();
            translate(x,y);
            fill(random(255), random(255), random(255), random(255));
            text(random(letters), 0, 0);
            pop();
        }
    }

    save("red-frame-" + frameCount + ".jpg")
    
    if (frameCount === 20) {
        noLoop();
    }
}
