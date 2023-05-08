import processing.video.*;

Capture cam;

//这个例子的主要知识点是，用两个数组编号来访问同一个数组，
//第一个数组编号来控制 新的摄像头影像放在哪个篮子里
//第二个数组编号来控制 当前屏幕上应该显示哪个篮子里的图片

int num=120;  //数组里一共存储120张图片
PImage[]pics;


int camIndex=0;  //第一个数组编号
int renderIndex=-num+1;  //第二个数组编号

void setup() {
  size(640, 480);


  pics=new PImage[num];
  
  String[]list=Capture.list();
  cam=new Capture(this, list[0]);  
  cam.start();
}


void draw() {
  if (cam.available()) {
    cam.read();
    pics[camIndex]=cam.copy();
    camIndex++;
    if (camIndex==num) {  //第一个数组编号到达最右侧后，回到最左边
      camIndex=0;
    }


    if (renderIndex>=0) {
      image(pics[renderIndex], 0, 0);
    }
    renderIndex++;
    if (renderIndex==num) {   //第二个数组编号到达最右侧后，回到最左边
      renderIndex=0;
    }
  }
}
