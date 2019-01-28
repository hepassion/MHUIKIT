MHUIKIT
MHUIKIT是一套iOS开发的一套UI框架， 只要继承了基础类，就可以轻松布局页面。实现了网络，UI，逻辑的分层。
每一个VC配置了一个dataConstructor，作为网络请求。VC上都有一个tableview。在dataConstructor中做网络请求，配置tableview的cell信息，到达UI布局的目的。

控制器层：MHTableViewController
新建的VC继承MHTableViewController，初始化 dataConstructor 

- (void) constructData {
if (_dataConstructor == nil) {
_dataConstructor = [[HomeDataConstructor alloc] init];
_dataConstructor.viewControllerDelegate = self;
_dataConstructor.delegate  = self;
}
// 初始化完毕 发送网络请求
[self.dataConstructor loadData];

}
在网络回调中刷新tableview(每个VC都有一个tableview)。
- (void) networkDataContructor:(MHNetworkDataConstructor *)dataConstructor didFinishWithData:(id)data { 
//刷新数据
[self.dataConstructor constructData];
self.adaptor.items = self.dataConstructor.items;
self.adaptor.arrayKeys = self.dataConstructor.arrayKeys;
self.adaptor.headerModels = self.dataConstructor.headerModels;
self.adaptor.footerModels = self.dataConstructor.footerModels; 
[self.uiTableView reloadData];
}

事件 ：

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
NSString *cellType = object.cellType;   
if ([cellType isEqualToString:@"cell.type.block"]) {
//do sth 
} 
}

网络层：
新建类继承MHNetworkDataConstructor ：

- (void)loadData { 
//请求接口 
在回包中调用VC中的代理方法。调用constructData 方法  ，刷新页面。
}


- (void)constructData {
[self.items removeAllObjects];
MHTitleDataModel *model = [MHTitleDataModel new];
model.content = @"cell.type.block";
model.cellClass = [MHTitleTableViewCell class];
model.cellType  = @"cell.type.block";
model.cellHeight = @([MHTitleTableViewCell heightForCell]);
model.delegate = self.viewControllerDelegate;
model.showTopLine = YES;
model.topLineColor = COLOR_GRAY;
model.selectedStyle = UITableViewCellSelectionStyleGray;
[self.items addObject:model]; 

//配置cell信息
}

MHAppSchemaObserver 和h5交互的类：
可以在APP启动时初始化一个单例，在该单例中注册协议。

MHAppSchemaObserver* observers      = [MHAppSchemaObserver sharedInstance];
//nlogin 为公共参数  可为多个，按顺序执行。
[observers addPublicParamName:@"nlogin"
invoke:^(NSString *paramName,
NSString *paramValue,
UIViewController *viewController,
void(^callback)(BOOL complete) ) {
//name 协议的名字  parameters 参数  viewController 当前控制器
LockViewController *lockVC = [LockViewController new];

UINavigationController *naVC = [UIApplication dd_rootNavigationController ];



WEAK(lockVC);
lockVC.completion = ^(BOOL success, id info) {
if (success) {

[weaklockVC dismissViewControllerAnimated:YES completion:nil];
callback(YES);
} else {

callback(NO);
}
};
[naVC presentViewController:lockVC animated:YES completion:nil];


}];
//单个协议
[observers addObserverName:@"service.task.deviceInfo"
serviceName:@"/deviceInfo"
invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
//name 协议的名字  parameters 参数  viewController 当前控制器
return nil;
}];
//h5 调用   href="mhuikit://Service/deviceInfo？nloin=y
会先执行nlogin的block， callback(YES)时继续调用deviceInfo的block，达到oc和h5交互 
oc也可以调用
NSURL *url = [NSURL URLWithString:@"mhuikit://Service/deviceInfo?nlogin=y" ];
[[MHAppSchemaObserver sharedInstance] openURL:url];达到同样的目的。





