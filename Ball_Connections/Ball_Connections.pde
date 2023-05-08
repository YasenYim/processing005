
int num=30;  //小球的数量

float[]xpos;    //所有小球的横坐标都放在这个数组里
float[]ypos;
float[]xvel;
float[]yvel;

float r=10;

void setup() {
  size(800, 600);

  xpos=new float[num];    //初始化数组，初始化之后，现在xpos是30个空篮子的集合
  ypos=new float[num];
  xvel=new float[num];
  yvel=new float[num];

  for (int i=0; i<num; i++) {  //把具体数值填充到每一个篮子里
    xpos[i]=random(r, width-r);
    ypos[i]=random(r, height-r);
    xvel[i]=random(-3, 3);
    yvel[i]=random(-3, 3);
  }
}

void draw() {
  //background(0);
  fill(0, 30);
  rect(0, 0, width, height);  //半透明方块，创造尾迹效果


  stroke(#6FCEFF);
  strokeWeight(2);
  for (int i=0; i<num; i++) {  //任意两个小球都握手且仅握手一次
    for (int j=i+1; j<num; j++) {
      if (dist(xpos[i], ypos[i], xpos[j], ypos[j])<100) {  //如果距离小于阈值，则在这两个小球之间连一根线
        line(xpos[i], ypos[i], xpos[j], ypos[j]);
      }
    }
  }

  fill(#6FCEFF);
  noStroke();
  for (int i=0; i<num; i++) {
    xpos[i]+=xvel[i];
    if (xpos[i]-r<0 || xpos[i]+r>width) {  //如果碰到左右墙壁，回弹
      xpos[i]-=xvel[i];
      xvel[i]*=-1;
    }

    ypos[i]+=yvel[i];
    if (ypos[i]-r<0 || ypos[i]+r>height) {    //如果碰到上下墙壁，回弹
      ypos[i]-=yvel[i];
      yvel[i]*=-1;
    }


    ellipse(xpos[i], ypos[i], r*2, r*2);
  }
}
