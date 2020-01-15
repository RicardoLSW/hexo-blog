---
title: 收集的一些常用的JS方法工具（持续更新）
date: 2020-01-15 10:55:04
---

1. 对象组成的数组去重

   ```javascript
   /**
    * 对象组成的数组去重
    * @param arr
    * @param attr
    * @returns {*}
    */
   export function uniqArray(arr, attr) {
     let hash = {}
     arr = arr.reduce((preVal, curVal) => {
       hash[curVal[attr]] ? '' : (hash[curVal[attr]] = true && preVal.push(curVal))
       return preVal
     }, [])
     return arr
   }
   ```

2. 时间格式化

   ```javascript
   /**
    * 时间格式化
    * @param value
    * @param fmt
    * @returns {*}
    */
   export function formatDate(value, fmt) {
     var regPos = /^\d+(\.\d+)?$/
     if (regPos.test(value)) {
       //如果是数字
       let getDate = new Date(value)
       let o = {
         'M+': getDate.getMonth() + 1,
         'd+': getDate.getDate(),
         'h+': getDate.getHours(),
         'm+': getDate.getMinutes(),
         's+': getDate.getSeconds(),
         'q+': Math.floor((getDate.getMonth() + 3) / 3),
         'S': getDate.getMilliseconds()
       }
       if (/(y+)/.test(fmt)) {
         fmt = fmt.replace(RegExp.$1, (getDate.getFullYear() + '').substr(4 - RegExp.$1.length))
       }
       for (let k in o) {
         if (new RegExp('(' + k + ')').test(fmt)) {
           fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)))
         }
       }
       return fmt
     } else {
       //TODO
       value = value.trim()
       return value.substr(0, fmt.length)
     }
   }
   ```

3. 生成水印

   ```javascript
   function watermark(settings) {
     //默认设置
     let defaultSettings = {
       watermark_className: 'ant-card',
       watermark_txt: 'text',
       watermark_x: 20,//水印起始位置x轴坐标
       watermark_y: 20,//水印起始位置Y轴坐标
       watermark_rows: 20,//水印行数
       watermark_cols: 20,//水印列数
       watermark_x_space: 400,//水印x轴间隔
       watermark_y_space: 300,//水印y轴间隔
       watermark_color: 'rgba(170, 170, 170, .2)',//水印字体颜色
       watermark_alpha: 1,//水印透明度
       watermark_fontsize: '30px',//水印字体大小
       watermark_font: '微软雅黑',//水印字体
       watermark_width: 210,//水印宽度
       watermark_height: 80,//水印长度
       watermark_angle: 15//水印倾斜度数
     }
     Object.assign(defaultSettings, settings)
     let oTemp = document.createDocumentFragment()
     let text = document.getElementsByClassName(defaultSettings.watermark_className)[0]
     console.log(text)
     //获取页面最大宽度
     let p_width = Math.max(text.scrollWidth, text.clientWidth)
     let cutWidth = p_width * 0.0150
     let page_width = p_width - cutWidth
     //获取页面最大高度
     let page_height = Math.max(text.scrollHeight, text.clientHeight) - 10
     // let page_height = document.body.scrollHeight+document.body.scrollTop;
     //如果将水印列数设置为0，或水印列数设置过大，超过页面最大宽度，则重新计算水印列数和水印x轴间隔
     if (defaultSettings.watermark_cols === 0 || (parseInt(defaultSettings.watermark_x + defaultSettings.watermark_width * defaultSettings.watermark_cols + defaultSettings.watermark_x_space * (defaultSettings.watermark_cols - 1)) > page_width)) {
       defaultSettings.watermark_cols = parseInt((page_width - defaultSettings.watermark_x + defaultSettings.watermark_x_space) / (defaultSettings.watermark_width + defaultSettings.watermark_x_space))
       defaultSettings.watermark_x_space = parseInt((page_width - defaultSettings.watermark_x - defaultSettings.watermark_width * defaultSettings.watermark_cols) / ((defaultSettings.watermark_cols - 1) === 0 ? 1 : (defaultSettings.watermark_cols - 1)))
     }
     //如果将水印行数设置为0，或水印行数设置过大，超过页面最大长度，则重新计算水印行数和水印y轴间隔
     if (defaultSettings.watermark_rows === 0 || (parseInt(defaultSettings.watermark_y + defaultSettings.watermark_height * defaultSettings.watermark_rows + defaultSettings.watermark_y_space * (defaultSettings.watermark_rows - 1)) > page_height)) {
       defaultSettings.watermark_rows = parseInt((defaultSettings.watermark_y_space + page_height - defaultSettings.watermark_y) / (defaultSettings.watermark_height + defaultSettings.watermark_y_space))
       defaultSettings.watermark_y_space = parseInt(((page_height - defaultSettings.watermark_y) - defaultSettings.watermark_height * defaultSettings.watermark_rows) / ((defaultSettings.watermark_rows - 1) === 0 ? 1 : (defaultSettings.watermark_rows - 1)))
     }
     let x
     let y
     for (let i = 0; i < defaultSettings.watermark_rows; i++) {
       y = defaultSettings.watermark_y + (defaultSettings.watermark_y_space + defaultSettings.watermark_height) * i
       for (let j = 0; j < defaultSettings.watermark_cols; j++) {
         x = defaultSettings.watermark_x + (defaultSettings.watermark_width + defaultSettings.watermark_x_space) * j
         let mask_div = document.createElement('div')
         mask_div.id = 'mask_div' + i + j
         mask_div.className = 'mask_div'
         mask_div.appendChild(document.createTextNode(defaultSettings.watermark_txt))
         //设置水印div倾斜显示
         mask_div.style.webkitTransform = 'rotate(-' + defaultSettings.watermark_angle + 'deg)'
         mask_div.style.MozTransform = 'rotate(-' + defaultSettings.watermark_angle + 'deg)'
         mask_div.style.msTransform = 'rotate(-' + defaultSettings.watermark_angle + 'deg)'
         mask_div.style.OTransform = 'rotate(-' + defaultSettings.watermark_angle + 'deg)'
         mask_div.style.transform = 'rotate(-' + defaultSettings.watermark_angle + 'deg)'
         mask_div.style.visibility = ''
         mask_div.style.position = 'absolute'
         mask_div.style.left = x + 'px'
         mask_div.style.top = y + 'px'
         mask_div.style.overflow = 'hidden'
         mask_div.style.zIndex = '9999'
         mask_div.style.pointerEvents = 'none'//pointer-events:none 让水印不遮挡页面的点击事件
         mask_div.style.opacity = defaultSettings.watermark_alpha
         mask_div.style.fontSize = defaultSettings.watermark_fontsize
         mask_div.style.fontFamily = defaultSettings.watermark_font
         mask_div.style.color = defaultSettings.watermark_color
         mask_div.style.textAlign = 'center'
         mask_div.style.width = defaultSettings.watermark_width + 'px'
         mask_div.style.height = defaultSettings.watermark_height + 'px'
         mask_div.style.display = 'block'
         oTemp.appendChild(mask_div)
       }
   
     }
   
     text.appendChild(oTemp)
   }
   
   /**
    * 已有水印的情况下，重新绘制水印
    */
   function drawWatermark(settings) {
     let defaultSettings = {
       watermark_className: 'ant-card',
       watermark_txt: 'text',
       watermark_x: 20,//水印起始位置x轴坐标
       watermark_y: 20,//水印起始位置Y轴坐标
       watermark_rows: 20,//水印行数
       watermark_cols: 20,//水印列数
       watermark_x_space: 400,//水印x轴间隔
       watermark_y_space: 300,//水印y轴间隔
       watermark_color: 'rgba(170, 170, 170, .2)',//水印字体颜色
       watermark_alpha: 1,//水印透明度
       watermark_fontsize: '30px',//水印字体大小
       watermark_font: '微软雅黑',//水印字体
       watermark_width: 250,//水印宽度
       watermark_height: 100,//水印长度
       watermark_angle: 15//水印倾斜度数
     }
     Object.assign(defaultSettings, settings)
     const mask_div = document.querySelector(`.${defaultSettings.watermark_className}`).querySelectorAll('.mask_div')
     let i = 0
     while (i < mask_div.length) {
       document.querySelector(`.${defaultSettings.watermark_className}`).removeChild(mask_div[i])
       i++
     }
     watermark(defaultSettings)
   }
   ```

4. 截取页面区域并导出为jpg/pdf

   ```javascript
   //需要以下两个插件
   import html2canvas from 'html2canvas'	//将指定区域生成为canvas
   import jsPDF from 'jspdf' 	//将canvas生成的图片转为pdf
   
   function saveToImg(eleId, imgName, fn) {
     const targetDom = document.querySelector(`#${eleId}`)
     const copyDom = targetDom.cloneNode(true)
     let cloneNode = targetDom.cloneNode(true)
     cloneNode.setAttribute('id', 'cloneNode')
     copyDom.style.width = targetDom.scrollWidth + 'px'
     copyDom.style.height = targetDom.scrollHeight + 'px'
     document.body.appendChild(copyDom)
     html2canvas(targetDom, {
       allowTaint: false,
       useCORS: true,
       height: targetDom.scrollHeight,
       width: targetDom.scrollWidth,
       ignoreElements: (element) => {
         if (element.className) {
           console.log(element.classList)
           if (element.classList.value.indexOf('noprint') !== -1) {
             return true
           }
         }
       }
     }).then(canvas => {
       // this.printShow = true
       copyDom.parentNode.removeChild(copyDom)
       // console.log(canvas.style.width)
       canvas.style.width = parseFloat(canvas.style.width) * 0.8 + 'px'
       canvas.style.height = parseFloat(canvas.style.height) * 0.8 + 'px'
       setTimeout(() => {
         // 另存为图片格式
         // const dataImg = new Image()
         // dataImg.src = canvas.toDataURL('image/png')
         // document.querySelector(`#${eleId}`).appendChild(dataImg)
         //
         // const alink = document.createElement('a')
         // alink.href = dataImg.src
         // alink.download = `${imgName}.jpg`
         // alink.click()
         // document.querySelector(`#${eleId}`).removeChild(dataImg)
         // document.querySelector(`#${eleId}`).innerHTML = cloneNode.innerHTML
   
         // 另存为pdf格式
         let pageData = canvas.toDataURL('image/jpeg', 1.0)
         let contentWidth = canvas.width
         let contentHeight = canvas.height
         //一页pdf显示html页面生成的canvas高度;
         let pageHeight = contentWidth / 592.28 * 841.89
         //未生成pdf的html页面高度
         let leftHeight = contentHeight
         //页面偏移
         let position = 0
         //a4纸的尺寸[595.28,841.89]，html页面生成的canvas在pdf中图片的宽高
         let imgWidth = 595.28
         let imgHeight = 592.28 / contentWidth * contentHeight
         let pdf = new jsPDF('', 'pt', 'a4')
         //有两个高度需要区分，一个是html页面的实际高度，和生成pdf的页面高度(841.89)
         //当内容未超过pdf一页显示的范围，无需分页
         if (leftHeight < pageHeight) {
           pdf.addImage(pageData, 'JPEG', 0, 0, imgWidth, imgHeight)
         } else {
           while (leftHeight > 0) {
             pdf.addImage(pageData, 'JPEG', 0, position, imgWidth, imgHeight)
             leftHeight -= pageHeight
             position -= 841.89
             //避免添加空白页
             if (leftHeight > 0) {
               pdf.addPage()
             }
           }
         }
         pdf.save(`${imgName}.pdf`)
         fn()
       }, 0)
     })
   }
   ```

5. 持续更新中。。。

