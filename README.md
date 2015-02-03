## CLRefreshView
一个简易下拉刷新和上拉加载的控件

### 使用方法
* 1. 把 `CLRefreshViewDemo/CLRerfreshView`整个拖入项目
* 2. 引入头文件:`UIScrollView+CLRefreshView.h`

### 简单用例
#### 简易下拉刷新头部控件


![(simpleHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/simpleHeader.gif "简易下拉刷新头部控件")

```objc
[self.tableView cl_addRefreshHeaderViewWithAction:^{
  //do some thing
}];
```
***
#### 浮动下拉刷新头部控件


![(floatHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/floatHeader.gif "浮动下拉刷新头部控件")

```objc
[self.tableView cl_addFloatRefreshHeaderViewWithAction:^{
  //do some thing
}];
```

***
#### 上拉加载底部控件


![(floatHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/simpleFooter.gif "上拉加载底部控件")
* 简易底部加载控件
```objc
[self.tableView cl_addRefreshFooterViewWithAction:^{
  //do some thing
}];
```
* 底部自动加载控件
```objc
[self.tableView cl_addAutoRefreshFooterViewWithAction:^{
  //do some thing
}];
```
`注意:`当底部控件为__自动加载控件__时可使用:
```objc
[self.tableView setCl_refreshFooterAutoLoad:(BOOL)autoLoad];
```
来设置底部控件__是否自动加载__
***

### 手动开始与结束刷新
* 开始刷新
  * 头部:
  ```objc
  [self.tableView cl_refreshHeaderStartAction];
  ```
  * 底部:
  ```objc
  [self.tableView cl_refreshFooterStartAction];
  ```
* 结束刷新
  * 头部:
  ```objc
  [self.tableView cl_refreshHeaderFinishAction];
  ```
  * 底部:
  ```objc
  [self.tableView cl_refreshFooterFinishAction];
  ```
`注意:完成刷新逻辑后都需要手动调用来结束控件的刷新`

***
### 注意
为了防止__循环引用__,若在block中使用`self` 需要声明为`weak`
```objc
__weak typeof(self) weakSelf = self;
[self.tableView cl_addRefreshHeaderViewWithAction:^{
  //[weakSelf doSomeThing];
}];
```

***
### 自定义
![(bubbleHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/bubble.gif "bubbleHeader")
![(clockHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/clock.gif "clockHeader")

* 自定义Loading显示样式

  可继承`CLAbstractLoadingView`,然后自己实现一些效果.
  
  具体可参照实例代码中的`CLBubbleLoadingView`以及`CLClockLoadingView`.




