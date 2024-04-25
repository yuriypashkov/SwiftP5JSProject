const letters = ["A", "B", "C", "D", "E"];

//const currentDate = new Date();
//const timestamp = currentDate.getTime()

function setup() {
  createCanvas(360, 360);
  frameRate(5);
}

function draw() {
    
    background(0, 211, 0);
    
    for (let y = 0; y <= height; y += 40) {
        for (let x = 0; x <= width; x += 40) {
            push();
            translate(x,y);
            fill(random(255), random(255), random(255), random(255));
            text(random(letters), 0, 0);
            pop();
        }
    }

    //save("green-frame-" + timestamp + "-" + frameCount + ".jpg")
    save("green-frame-" + frameCount + ".jpg")
    
    if (frameCount === 20) {
        noLoop();
    }
}
