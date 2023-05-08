int num=30;  //小球数量

float[]xpos;  //所有小球的横坐标都放到这个数组里
float[]ypos;
float[]xspd;
float[]yspd;
color[]c;
float r=4;  //小球半径

void setup() {
  size(800, 600);

  xpos=new float[num];
  ypos=new float[num];
  xspd=new float[num];
  yspd=new float[num];
  c=new color[num];

  for (int i=0; i<num; i++) {
    xpos[i]=width/2;
    ypos[i]=height/2;
    float angle=random(TWO_PI);  //随机角度
    float vel=random(2, 6);    //随机速度值
    //c[i]=color(random(150, 255), random(150, 255), random(150, 255));
    c[i]=#61B4E5;
    xspd[i]=cos(angle)*vel;  //用角度和速度大小，换算出横轴和纵轴的速度分量
    yspd[i]=sin(angle)*vel;
  }
  noStroke();
}

void draw() {
  fill(#673F3F,30);
  rect(0,0,width,height);

  for (int i=0; i<num; i++) {  //遍历每一个小球
  
    xpos[i]+=xspd[i];          //更新横坐标的值
    if (xpos[i]-r<0 || xpos[i]+r>width) {  //如果碰到左右墙壁，则反弹
      xpos[i]-=xspd[i];  
      xspd[i]*=-1;  //注意反弹的意思并不是改变位置，而是改变速度的方向
    }
    ypos[i]+=yspd[i];
    if (ypos[i]-r<0 || ypos[i]+r>height) {
      ypos[i]-=yspd[i];
      yspd[i]*=-1;
    }
  }

  for (int i=0; i<num; i++) {  //任意两个小球之间都握手一次且只握手一次
    for (int j=i+1; j<num; j++) {
      if (dist(xpos[i], ypos[i], xpos[j], ypos[j])<120) {  //如果距离小于阈值，则连一根线
        stroke(#61B4E5);
        line(xpos[i], ypos[i], xpos[j], ypos[j]);
      }
    }
  }


  for (int i=0; i<num; i++) {
    fill(c[i]);
    noStroke();
    ellipse(xpos[i], ypos[i], r*2, r*2);
  }
}
