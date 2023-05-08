int num=20000;  //一共要画2W个点

float[]xpos;  //每个点的横纵坐标和半径
float[]ypos;
float[]rad;

int index;
float minRad=1;  //每个点的半径值介于最小半径和最大半径之间
float maxRad=3;

void setup() {
  size(1280,720);
  //fullScreen();
  background(70, 40, 20);
  noStroke();
  fill(255);

  xpos=new float[num];  //初始化三个数组，现在每个数组里都包含2W个空篮子了
  ypos=new float[num];
  rad=new float[num];

  //填充10个点作为初始值
  for (int i=0; i<5; i++) {  //对于2W个篮子里的第0~4个，赋一个随机值
    xpos[i]=random(width);
    ypos[i]=0;
    rad[i]=random(minRad, maxRad);
    ellipse(xpos[i], ypos[i], rad[i]*2, rad[i]*2);
  }

  for (int i=5; i<10; i++) {  //对于2W个篮子里的第5~9个，赋一个随机值
    xpos[i]=random(width);
    ypos[i]=height;
    rad[i]=random(minRad, maxRad);
    ellipse(xpos[i], ypos[i], rad[i]*2, rad[i]*2);
  }

  index=10;  //现在编号为0~9 的篮子都已经填上了数值，下一个空篮子的编号是10
}

void draw() {

  for (int t=0; t<60; t++) {  //每一帧里，计算并填充60个点

    float randomX=random(width);  //先在屏幕上随机生成一个新的点
    float randomY=random(height);
    float randomRad=random(minRad, maxRad);  //并且随机出一个半径

    //下面要从已填充的数据里找出距离刚刚生成的新点最近的点
    int pointIndex=-1;    //用来记录寻找过程中"当下最近点"的编号
    float minSqDist=99999999;  //用来记录"当下最近点"和新点的距离，初始时先放一个极大的距离在篮子里
    float sqDist;  //距离的平方，只是比较大小，无需知道具体的距离，所以无需开方，省运算

    for (int i=0; i<index; i++) {  //把所有已填充的点遍历一遍，来找到最近的点
      sqDist=sq(randomX-xpos[i])+sq(randomY-ypos[i]);
      if (sqDist<minSqDist) {
        minSqDist=sqDist;
        pointIndex=i;
      }
    }

    float angle=atan2(randomY-ypos[pointIndex], randomX-xpos[pointIndex]);  //计算出新点在"最近点"的哪个方向上
    xpos[index]=xpos[pointIndex]+cos(angle)*rad[pointIndex];
    ypos[index]=ypos[pointIndex]+sin(angle)*rad[pointIndex];
    rad[index]=randomRad;
    ellipse(xpos[index], ypos[index], rad[index]*2, rad[index]*2);  //把新点挪到"最近点"的旁边，就在上面算出来的方向上

    if (index<num-1) {  //完成了一个点，把index 挪到下一个空篮子的位置。
      index++;
    }
  }
}
