## CLRefreshView
一个简易下拉刷新和上拉加载的控件

### 使用方法
* 1. 把 `CLRefreshViewDemo/CLRerfreshView`整个拖入项目
* 2. 引入头文件:`UIScrollView+CLRefreshView.h`

### 简单用例
* 简易下拉刷新头部控件


***
![(simpleHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/simpleHeader.gif "简易下拉刷新头部控件")


```objc
[self.tableView cl_addRefreshHeaderViewWithAction:^{
  //do some thing
}];
```


***
* 浮动下拉刷新头部控件
![(floatHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/floatHeader.gif "浮动下拉刷新头部控件")
```objc
[self.tableView cl_addFloatRefreshHeaderViewWithAction:^{
  //do some thing
}];
```
***
*上拉加载底部控件
![(floatHeader)](https://github.com/unknownBug/CLRefreshView/blob/master/Screenshots/simpleFooter.gif "上拉加载底部控件")
```objc
[self.tableView cl_addRefreshFooterViewWithAction:^{
  //do some thing
}];
```

*底部自动加载控件
```objc
[self.tableView cl_addAutoRefreshFooterViewWithAction:^{
  //do some thing
}];
```
'注意:'当底部控件为__自动加载控件__时可使用:
```objc
[self.tableView setCl_refreshFooterAutoLoad:(BOOL)autoLoad];
```
来设置底部控件是否自动加载
***


## 自定义




