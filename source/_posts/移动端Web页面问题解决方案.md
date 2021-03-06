---
title: 移动端Web页面问题解决方案
date: 2019-12-15 17:48:58
---

### 安卓浏览器看背景图片，有些设备会模糊

用同等比例的图片在PC机上很清楚，但是手机上很模糊，原因是什么呢？

经过研究，是devicePixelRatio作怪，**<u>因为手机分辨率太小，如果按照分辨率来显示网页，这样字会非常小，所以苹果当初就把iPhone 4的960*640分辨率，在网页里只显示了480*320</u>**，这样`devicePixelRatio＝2`。现在android比较乱，有1.5的，有2的也有3的。

想让图片在手机里显示更为清晰，必须使用2x的背景图来代替img标签（一般情况都是用2倍）。例如一个div的宽高是100100，背景图必须得200200，然后`background-size:contain`;，这样显示出来的图片就比较清晰了。

代码可以如下：

```css
element{
    background:url(../images/icon/all.png) no-repeat center center;
	-webkit-background-size:50px 50px;
	background-size: 50px 50px;display:inline-block; width:100%; height:50px; 
}
```

> 或者指定 `background-size:contain`;都可以，大家试试！ 

### **图片加载** 

遇到图片加载很慢的问题，对这种情况，手机开发一般用canvas方法加载：

具体的canvas API 参见：http://javascript.ruanyifeng.com/htmlapi/canvas.html

下面举例说明一个canvas的例子：

```html
<li><canvas></canvas></li> 
```

js动态加载图片和li 总共举例17张图片

```javascript
var total=17; 
var zWin=$(window); 
var render=function(){ 
  var padding=2; 
  var winWidth=zWin.width(); 
  var picWidth=Math.floor((winWidth-padding*3)/4); 
  var tmpl =''; 
  for (var i=1;i<=totla;i++){ 
  var p=padding; 
  var imgSrc='img/'+i+'.jpg'; 
  if(i%4==1){ 
   p=0; 
  } 
  tmpl +='<li style="width:'+picWidth+'px;height:'+picWidth+'px;padding-left:'+p+'px;padding-top:'+padding+'px;"><canvas id="cvs_'+i+'"></canvas></li>'; 
  var imageObj = new Image(); 
  imageObj.index = i; 
  imageObj.onload = function(){ 
    var cvs =$('#cvs_'+this.index)[0].getContext('2d'); 
    cvs.width = this.width; 
    cvs.height=this.height; 
    cvs.drawImage(this,0,0); 
  } 
  imageObj.src=imgSrc; 
  } 
} 
render(); 
```

### **禁止手机中网页放大和缩小** 

这点是最基本的，最为手机网站开发者来说应该都知道的，就是设置meta中的viewport还有就是，有些手机网站我们看到如下声明：

```html
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
```

设置了DTD的方式是XHTML的写法，假如我们页面运用的是html5，可以不用设置DTD,直接声明<!DOCTYPE html>。 

使用`viewport`使页面禁止缩放。 通常把`user-scalable`设置为0来关闭用户对页面视图缩放的行为。 

```html
<meta name="viewport" content="user-scalable=0" />
```

但是为了更好的兼容，我们会使用完整的viewport设置。 

```html
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" />
```

> `user-scalable=0`,有的人也写成`user-scalable=no`，都可以的

### **apple-mobile-web-app-capable** 

`apple-mobile-web-app-capable`是设置Web应用是否以全屏模式运行

```html
<meta name="apple-mobile-web-app-capable" content="yes">
```

> 说明： 如果content设置为yes，Web应用会以全屏模式运行，反之，则不会。content的默认值是no，表示正常显示。你可以通过只读属性window.navigator.standalone来确定网页是否以全屏模式显示。 

### **format-detection** 

`format-detection` 启动或禁用自动识别页面中的电话号码。 

```html
<meta name="format-detection" content="telephone=no">
```

### **html5调用安卓或者ios的拨号功能** 

html5提供了自动调用拨号的标签，只要在a标签的href中添加tel:就可以了

```html
<a href="tel:4008106999,1034">400-810-6999 转 1034</a>
```

拨打手机直接如下 

```html
<a href="tel:15677776767">点击拨打15677776767</a>
```

### 上下拉动滚动条时卡顿、慢

```css
body {
  -webkit-overflow-scrolling: touch;
  overflow-scrolling: touch;
}
```

> Android3+和iOS5+支持CSS3的新属性为overflow-scrolling 

### **禁止复制、选中文本** 

```css
Element {
  -webkit-user-select: none;
  -moz-user-select: none;
  -khtml-user-select: none;
   user-select: none;
}
```

### **长时间按住页面出现闪退** 

```css
element {
  -webkit-touch-callout: none;
}
```

### **iphone及ipad下输入框默认内阴影** 

```css
Element{
  -webkit-appearance: none; 
}
```

### **ios和android下触摸元素时出现半透明灰色遮罩** 

```css
Element {
  -webkit-tap-highlight-color:rgba(255,255,255,0)
}
```

> 设置alpha值为0就可以去除半透明灰色遮罩，备注：transparent的属性值在android下无效。 

### **active兼容处理 即 伪类 :active 失效** 

* 方法一：body添加`ontouchstart `

  ```html
  <body ontouchstart="">
  ```

* 方法二：js给 document 绑定 `touchstart` 或` touchend `事件 

  ```html
  <style>
      a {
       color: #000;
      }
      a:active {
       color: #fff;
      }
  </style>
  <a herf=foo >bar</a>
  <script>
   	document.addEventListener('touchstart',function(){},false);
  </script>
  ```

### **动画定义3D启用硬件加速** 

```css
Element {
  -webkit-transform:translate3d(0, 0, 0);
  transform: translate3d(0, 0, 0);
}
```

> 注意：3D变形会消耗更多的内存与功耗

### **webkit mask 兼容处理** 

某些低端手机不支持css3 mask，可以选择性的降级处理。

比如可以使用js判断来引用不同class：

```javascript
if( 'WebkitMask' in document.documentElement.style){
  alert('支持mask');
} else {
  alert('不支持mask');
}
```

### **旋转屏幕时，字体大小调整的问题** 

```css
html, body, form, fieldset, p, div, h1, h2, h3, h4, h5, h6 {
  -webkit-text-size-adjust:100%;
}
```

### **transition闪屏** 

```css
element{
    /* 设置内嵌的元素在 3D 空间如何呈现：保留3D */
    -webkit-transform-style: preserve-3d;
    /* 设置进行转换的元素的背面在面对用户时是否可见：隐藏 */
    -webkit-backface-visibility:hidden;
}
```

### **圆角bug** 

某些Android手机圆角失效 

```css
background-clip: padding-box;
```

### **顶部状态栏背景色** 

```html
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
```

> 说明：除非你先使用`apple-mobile-web-app-capable`指定全屏模式，否则这个meta标签不会起任何作用。
>
> 如果content设置为default，则状态栏正常显示。如果设置为blank，则状态栏会有一个黑色的背景。如果设置为`blank-translucent`，则状态栏显示为黑色半透明。如果设置为default或blank，则页面显示在状态栏的下方，即状态栏占据上方部分，页面占据下方部分，二者没有遮挡对方或被遮挡。如果设置为`blank-translucent`，则页面会充满屏幕，其中页面顶部会被状态栏遮盖住（会覆盖页面20px高度，而iphone4和itouch4的Retina屏幕为40px）。默认值是default。

### **设置缓存** 

```html
<meta http-equiv="Cache-Control" content="no-cache" />
```

> 说明：手机页面通常在第一次加载后会进行缓存，然后每次刷新会使用缓存而不是去重新向服务器发送请求。如果不希望使用缓存可以设置`no-cache`。 

### **桌面图标** 

```html
<link rel="apple-touch-icon" href="touch-icon-iphone.png" />
<link rel="apple-touch-icon" sizes="76x76" href="touch-icon-ipad.png" />
<link rel="apple-touch-icon" sizes="120x120" href="touch-icon-iphone-retina.png" />
<link rel="apple-touch-icon" sizes="152x152" href="touch-icon-ipad-retina.png" />
```

iOS下针对不同设备定义不同的桌面图标。如果不定义则以当前屏幕截图作为图标。

上面的写法可能大家会觉得会有默认光泽，下面这种设置方法可以去掉光泽效果，还原设计图的效果！

```html
<link rel="apple-touch-icon-precomposed" href="touch-icon-iphone.png" />
```

图片尺寸可以设定为5757（px）或者Retina可以定为114114（px），ipad尺寸为72*72（px) 

### **启动画面** 

```html
<link rel="apple-touch-startup-image" href="start.png"/>
```

iOS下页面启动加载时显示的画面图片，避免加载时的白屏。

可以通过madia来指定不同的大小：

```html
<!--iPhone-->
<link href="apple-touch-startup-image-320x460.png" media="(device-width: 320px)" rel="apple-touch-startup-image" />
 
<!-- iPhone Retina -->
<link href="apple-touch-startup-image-640x920.png" media="(device-width: 320px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />
 
<!-- iPhone 5 -->
<link rel="apple-touch-startup-image" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)" href="apple-touch-startup-image-640x1096.png">
 
<!-- iPad portrait -->
<link href="apple-touch-startup-image-768x1004.png" media="(device-width: 768px) and (orientation: portrait)" rel="apple-touch-startup-image" />
 
<!-- iPad landscape -->
<link href="apple-touch-startup-image-748x1024.png" media="(device-width: 768px) and (orientation: landscape)" rel="apple-touch-startup-image" />
 
<!-- iPad Retina portrait -->
<link href="apple-touch-startup-image-1536x2008.png" media="(device-width: 1536px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />
 
<!-- iPad Retina landscape -->
<link href="apple-touch-startup-image-1496x2048.png"media="(device-width: 1536px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)"rel="apple-touch-startup-image" />
```

### **浏览器私有及其它meta** 

以下属性在项目中没有应用过，可以写一个demo测试以下

1. QQ浏览器私有 

   * 全屏模式 

     ```html
     <meta name="x5-fullscreen" content="true">
     ```

   * 强制竖屏 

     ```html
     <meta name="x5-orientation" content="portrait">
     ```

   * 强制横屏 

     ```html
     <meta name="x5-orientation" content="landscape">
     ```

   * 应用模式 

     ```html
     <meta name="x5-page-mode" content="app">
     ```

2. UC浏览器私有 

   * 全屏模式 

     ```html
     <meta name="full-screen" content="yes">
     ```

   * 强制竖屏 

     ```html
     <meta name="screen-orientation" content="portrait">
     ```

   * 强制横屏 

     ```html
     <meta name="screen-orientation" content="landscape">
     ```

   * 应用模式 

     ```html
     <meta name="browsermode" content="application">
     ```

3. 其它 

   * 针对手持设备优化，主要是针对一些老的不识别viewport的浏览器，比如黑莓 

     ```html
     <meta name="HandheldFriendly" content="true">
     ```

   * 微软的老式浏览器 

     ```html
     <meta name="MobileOptimized" content="320">
     ```

   * windows phone 点击无高光 

     ```html
     <meta name="msapplication-tap-highlight" content="no">
     ```

### **IOS中input键盘事件keyup、keydown、keypress支持不是很好** 

问题是这样的，用input search做模糊搜索的时候，在键盘里面输入关键词，会通过ajax后台查询，然后返回数据，然后再对返回的数据进行关键词标红。用input监听键盘keyup事件，在安卓手机浏览器中是可以的，但是在ios手机浏览器中变红很慢，用输入法输入之后，并未立刻相应keyup事件，只有在通过删除之后才能相应！ 

**解决办法： **可以用html5的`oninput`事件去代替`keyup `

```html
<input type="text" id="testInput">
<script type="text/javascript">
  document.getElementById('testInput').addEventListener('input', function(e){
    var value = e.target.value;
  });
</script>
```

### **h5网站input 设置为type=number的问题** 

h5网页input 的type设置为number一般会产生三个问题，一个问题是maxlength属性不好用了。另外一个是form提交的时候，默认给取整了。三是部分安卓手机出现样式问题。 

**问题一解决方法:**

```html
<input type="number" oninput="checkTextLength(this ,10)"> 
<script>
    function checkTextLength(obj, length) {  
          if(obj.value.length > length)  {     
            obj.value = obj.value.substr(0, length);  
          }  
    }
</script>
```

 **问题二解决方法:**

> 是因为form提交默认做了表单验证，step默认是1,要设置step属性，假如保留2位小数，写法如下： 

```html
<input type="number" step="0.01" />
```

关于step，我在这里做简单的介绍，input 中type=number，一般会自动生成一个上下箭头，点击上箭头默认增加一个step，点击下箭头默认会减少一个step。number中默认step是1。也就是step=0.01,可以允许输入2位小数，并且点击上下箭头分别增加0.01和减少0.01。 

> 假如step和min一起使用，那么数值必须在min和max之间。 

### **ios 设置input 按钮样式会被默认样式覆盖** 

**解决方法：**

```css
input,textarea {
  border: 0; 
  -webkit-appearance: none; 
}
```

> 设置默认样式为`none `

### **IOS键盘字母输入，默认首字母大写** 

**解决方案:**设置如下属性 

```html
<input type="text" autocapitalize="off" />
```

### **select 下拉选择设置右对齐** 

```css
select option {
	direction: rtl;
}
```

### **通过transform进行skew变形，rotate旋转会造成出现锯齿现象** 

```css
element{
    -webkit-transform: rotate(-4deg) skew(10deg) translateZ(0);
     transform: rotate(-4deg) skew(10deg) translateZ(0);
     outline: 1px solid rgba(255,255,255,0)
}
```

> 关键是最后一个的outline属性设置

### **移动端点击300ms延迟** 

300ms尚可接受，不过因为300ms产生的问题，我们必须要解决。300ms导致用户体验并不是很好，解决这个问题，我们一般在移动端用tap事件来取代click事件。

推荐两个js，一个是`fastclick`，一个是`tap.js`

### **移动端点透问题** 

**案例如下：** 

```html
<div id="haorooms">点头事件测试</div>
<a href="www.jb51.net">www.jb51.net</a>
```

div是绝对定位的蒙层,并且z-index高于a。而a标签是页面中的一个链接，我们给div绑定tap事件： 

```javascript
$('#haorooms').on('tap',function(){
	$('#haorooms').hide();
});
```

我们点击蒙层时 div正常消失，但是当我们在a标签上点击蒙层时，发现a链接被触发，这就是所谓的点透事件。 

**原因：**`touchstart `早于` touchend` 早于`click`。 亦即`click`的触发是有延迟的，这个时间大概在300ms左右，也就是说我们tap触发之后蒙层隐藏， 此时 click还没有触发，300ms之后由于蒙层隐藏，我们的click触发到了下面的a链接上。 

**解决方法：**

1. 尽量都使用touch事件来替换click事件。例如用touchend事件(推荐)。 
2. 用fastclick，https://github.com/ftlabs/fastclick 
3. 用`preventDefault`阻止a标签的click 
4. 延迟一定的时间(300ms+)来处理事件 （不推荐） 
5. 以上一般都能解决，实在不行就换成click事件。  

下面介绍一下`touchend`事件，如下：

```javascript
$("#haorooms").on("touchend", function (event) {
   event.preventDefault();
});
```

### **消除 IE10 里面的那个叉号** 

```css
element{
    input:-ms-clear{display:none;}
}
```

### **关于 iOS 与 OS X 端字体的优化(横竖屏会出现字体加粗不一致等)** 

iOS 浏览器横屏时会重置字体大小，设置 text-size-adjust 为 none 可以解决 iOS 上的问题，但桌面版 Safari 的字体缩放功能会失效，因此最佳方案是将 text-size-adjust 为 100% 。 

```css
element{
    -webkit-text-size-adjust: 100%;
    -ms-text-size-adjust: 100%;
    text-size-adjust: 100%;
}
```

### **关于 iOS 系统中，中文输入法输入英文时，字母之间可能会出现一个六分之一空格** 

可以通过正则去掉 

```javascript
this.value = this.value.replace(/\u2006/g, '');
```

### **移动端 HTML5 audio autoplay 失效问题** 

这个不是 BUG，由于自动播放网页中的音频或视频，会给用户带来一些困扰或者不必要的流量消耗，所以苹果系统和安卓系统通常都会禁止自动播放和使用 JS 的触发播放，必须由用户来触发才可以播放。

**解决方法思路：**先通过用户 touchstart 触碰，触发播放并暂停（音频开始加载，后面用 JS 再操作就没问题了）。

**解决代码：**

```javascript
document.addEventListener('touchstart', function () {
  document.getElementsByTagName('audio')[0].play();
  document.getElementsByTagName('audio')[0].pause();
});	
```

### **移动端 HTML5 input date 不支持 placeholder 问题** 

```html
<input placeholder="Date" class="textbox-n" type="text" onfocus="(this.type='date')"  id="date">
```

> 说明：有的浏览器可能要点击两遍！ 

### **部分机型存在type为search的input，自带close按钮样式修改方法** 

有些机型的搜索input控件会自带close按钮（一个伪元素），而通常为了兼容所有浏览器，我们会自己实现一个，此时去掉原生close按钮的方法为 

```css
#Search::-webkit-search-cancel-button{
  display: none;  
}
```

### **唤起select的option展开** 

**zepto方式**

```javascript
$(sltElement).trrgger("mousedown");
```

 **原生js方式**

```javascript
function showDropdown(sltElement) {
    var event;
    event = document.createEvent('MouseEvents');
    event.initMouseEvent('mousedown', true, true, window);
    sltElement.dispatchEvent(event);
};
```

 