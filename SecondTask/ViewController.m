//
//  ViewController.m
//  SecondTask
//
//  Created by Jinwoo on 2023/06/22.
//

#import "ViewController.h"


@interface ViewController ()  < UITableViewDelegate , UITableViewDataSource, ViewUserInfoDelefate >
{
    ViewUserInfo *openView; // view
    UserInfo *userInfo; // 객체
    
    NSMutableArray *mutableArray; // 정보가 담겨있는 리스트
    
    UITableView *tableView;
    
    UILabel *nameBox;
    UILabel *jenderBox;
    UILabel *numBox;
    
    NSInteger selectTableindex;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self f_viewDraw];
    
}

- (void)f_viewDraw;{
    
    // 추가버튼 그리기
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 175, CGRectGetMinY(self.view.frame) + 100, 170, 50)];
    [btnAdd setBackgroundColor:[UIColor redColor]];
    [btnAdd setTitle:@"추가" forState:UIControlStateNormal]; // 텍스트
    [btnAdd addTarget:self action:@selector(onBtnAddTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 100, 170, 50)];
    [btnEdit setBackgroundColor:[UIColor purpleColor]];
    [btnEdit setTitle:@"수정" forState:UIControlStateNormal]; // 텍스트
    [btnEdit addTarget:self action:@selector(onBtnEditTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEdit];
    
    UIButton *btnSave1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 160, 170, 50)];
    [btnSave1 setBackgroundColor:[UIColor orangeColor]];
    [btnSave1 setTitle:@"Save NSUserDefaults" forState:UIControlStateNormal]; // 텍스트
    [btnSave1 addTarget:self action:@selector(onBtnSaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    [[btnSave1 titleLabel] setFont:[UIFont systemFontOfSize:17]];
    [btnSave1 setTag:1];
    [self.view addSubview:btnSave1];

    UIButton *btnGet1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 220, 80, 50)];
    [btnGet1 setBackgroundColor:[UIColor grayColor]];
    [btnGet1 setTitle:@"불러오기" forState:UIControlStateNormal]; // 텍스트
    [btnGet1 addTarget:self action:@selector(onBtnGetTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnGet1 setTag:1];
    [self.view addSubview:btnGet1];
    
    UIButton *btnClear1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 95, CGRectGetMinY(self.view.frame) + 220, 80, 50)];
    [btnClear1 setBackgroundColor:[UIColor brownColor]];
    [btnClear1 setTitle:@"Clear" forState:UIControlStateNormal]; // 텍스트
    [btnClear1 addTarget:self action:@selector(onBtnClearTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnClear1 setTag:1];
    [self.view addSubview:btnClear1];
    
    UIButton *btnSave2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) -175, CGRectGetMinY(self.view.frame) + 160, 170, 50)];
    [btnSave2 setBackgroundColor:[UIColor orangeColor]];
    [btnSave2 setTitle:@"Save Document" forState:UIControlStateNormal]; // 텍스트
    [btnSave2 addTarget:self action:@selector(onBtnSaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    [[btnSave2 titleLabel] setFont:[UIFont systemFontOfSize:17]];
    [btnSave2 setTag:2];
    [self.view addSubview:btnSave2];

    UIButton *btnGet2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) -175, CGRectGetMinY(self.view.frame) + 220, 80, 50)];
    [btnGet2 setBackgroundColor:[UIColor grayColor]];
    [btnGet2 setTitle:@"불러오기" forState:UIControlStateNormal]; // 텍스트
    [btnGet2 addTarget:self action:@selector(onBtnGetTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnGet2 setTag:2];
    [self.view addSubview:btnGet2];
    
    UIButton *btnClear2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) -85, CGRectGetMinY(self.view.frame) + 220, 80, 50)];
    [btnClear2 setBackgroundColor:[UIColor brownColor]];
    [btnClear2 setTitle:@"Clear" forState:UIControlStateNormal]; // 텍스트
    [btnClear2 addTarget:self action:@selector(onBtnClearTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnClear2 setTag:2];
    [self.view addSubview:btnClear2];
    
    nameBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 280, 100, 45)];
    [nameBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [nameBox.layer setBorderWidth: 3.0];
    [nameBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:nameBox];
    
    jenderBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 110, CGRectGetMinY(self.view.frame) + 280, 50, 45)];
    [jenderBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [jenderBox.layer setBorderWidth: 3.0];
    [jenderBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:jenderBox];
    
    numBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 165, CGRectGetMinY(self.view.frame) + 280, CGRectGetWidth(self.view.frame) - 170, 45)];
    [numBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [numBox.layer setBorderWidth: 3.0];
    [numBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:numBox];
    
    tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, CGRectGetMinY(self.view.frame) + 330, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 170)];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [tableView setRowHeight:50];
    [self.view addSubview:tableView];
    
    mutableArray = [[NSMutableArray alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return [mutableArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UILabel *lblName = nil;
    UILabel *lblGender = nil;
    UILabel *lblNumber = nil;
    
    UITableViewCell* cellTable = [tableView dequeueReusableCellWithIdentifier:@"CALENDAR_TEST"];
    if (cellTable == nil) {
        cellTable = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CALENDAR_TEST"];
        cellTable.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cellTable setClipsToBounds:YES];
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 45)];
        [lblName setBackgroundColor:[UIColor lightGrayColor]];
        [lblName setTextAlignment:NSTextAlignmentCenter];
        [lblName setTag:1];
        [cellTable addSubview:lblName];
        
        
        
        lblGender = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 50, 45)];
        [lblGender setBackgroundColor:[UIColor lightGrayColor]];
        [lblGender setTextAlignment:NSTextAlignmentCenter];
        [lblGender setTag:2];
        [cellTable addSubview:lblGender];
        

        lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(165, 0, CGRectGetWidth(tableView.frame) - 170, 45)];
        [lblNumber setBackgroundColor:[UIColor lightGrayColor]];
        [lblNumber setTextAlignment:NSTextAlignmentCenter];
        [lblNumber setTag:3];
        [cellTable addSubview:lblNumber];
        
        
    }else{
        
        lblName = [cellTable viewWithTag:1];
        lblGender = [cellTable viewWithTag:2];
        lblNumber = [cellTable viewWithTag:3];

    }
    
//    NSString *sName = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:0];
//    NSString *sJender = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:1];
//    NSString *sNum = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:2];
    
    UserInfo *info = [mutableArray objectAtIndex:indexPath.row];

    NSString *sMaskingNum = [self MaskingPhoneNum:info.phoneNum];
    
    [lblName setText:info.name];
    [lblGender setText:info.jender];
    [lblNumber setText:sMaskingNum];
    
    return cellTable;
    
    
}

- (void)onBtnAddTouch:(UIButton*)sender // 추가버튼 클릭시
{
    
    openView = [[ViewUserInfo alloc] init];
    openView.delegate = self;
    
    [self addChildViewController:openView];
    [self.view addSubview:openView.view];
    [openView didMoveToParentViewController:self];
    
}

- (void)onBtnEditTouch:(UIButton*)sender // 수정버튼 클릭시
{
    
    if (userInfo.name == nil && userInfo.phoneNum == nil && userInfo.jender == nil ) {
        [self ShowAlert:@"테이블 데이터를 클릭해주세요."];
        return;
    }
    
    openView = [[ViewUserInfo alloc] init];
    openView.delegate = self;
    
    [openView setUserInfo:userInfo];
    
    [self addChildViewController:openView];
    [self.view addSubview:openView.view];
    [openView didMoveToParentViewController:self];
    
}

- (void)onBtnSaveTouch:(UIButton*)sender // 저장 버튼 클릭시
{
    
    
    if ([mutableArray count] == 0) {
        [self ShowAlert:@"정보를 추가해 주세요."];
        return;
    }
    
    NSMutableArray *arrayData = [[NSMutableArray alloc] init]; // 기존 mutableArray 가 객체가 담겨있어서 배열로 풀어주기
    
    for (int i = 0; i< [mutableArray count]; i++){
        UserInfo *info = [mutableArray objectAtIndex:i];
        
        [arrayData addObject:@[info.name, info.jender, info.phoneNum]];
        NSLog(@"%@ %@ %@",info.name, info.jender, info.phoneNum);
    }

    
    if ([sender tag] == 1) {

        NSLog(@"Save  Tag : 1");
    
        [[NSUserDefaults standardUserDefaults] setObject:arrayData forKey:@"USER_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        
        NSLog(@"Save  Tag : 2");
        
        NSData *jsonChange = [NSJSONSerialization dataWithJSONObject:arrayData options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonResult = [[NSString alloc] initWithData:jsonChange encoding:NSUTF8StringEncoding];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/USER_INFO.txt", documentsDirectory];
        
        NSError *err = nil;
        BOOL ret = [jsonResult writeToFile:fullFileName atomically:NO encoding:NSUTF8StringEncoding error:&err];
        
        if (err != nil){
            [err localizedFailureReason];
        }

        if (!ret){
            NSLog(@"Save Failed");
        }
        else{
            NSLog(@"Save Success");
        }
    }
}

- (void)onBtnGetTouch:(UIButton*)sender // 불러오기 버튼 클릭
{
    
    NSMutableArray *arrayData;
    NSString *getData;
    
    if ([sender tag] == 1) {
        
        NSLog(@"Get Tag : 1");
        
        arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_INFO"];
        
    }
    else {
        
        NSLog(@"Get Tag : 2");
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/USER_INFO.txt", documentsDirectory];
        
        getData = [[NSString alloc]initWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
        
        NSData *data = [[NSData alloc] initWithBytes:[getData UTF8String] length:[getData lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
        //    NSData *videoData = [NSData dataWithContentsOfFile: getData];
        arrayData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
    if (arrayData == nil) {
        NSLog(@"Get Failed");
        return;
    }
    
    mutableArray = [[NSMutableArray alloc]init]; // 불러오는거 확인하기위해 초기화
    
    
    for (int i = 0; i< [arrayData count]; i++){ // 객체로 테이블 셋팅하기때문에 다시 객체로 변환해주기
        
        UserInfo *info = [UserInfo alloc];
        
        info.name = [[arrayData objectAtIndex:i]objectAtIndex:0];
        info.jender = [[arrayData objectAtIndex:i]objectAtIndex:1];
        info.phoneNum = [[arrayData objectAtIndex:i]objectAtIndex:2];
        
        [mutableArray addObject:info];
    }
    
    NSLog(@"Get Success");
    
    [tableView reloadData];
    
}


- (void)onBtnClearTouch:(UIButton*)sender // 저장 버튼 클릭시
{
    
    NSString *sClear = @"";
    
    if ([sender tag] == 1) {

        NSLog(@"Clear  Tag : 1");
        
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        
        [[NSUserDefaults standardUserDefaults] setObject:arrayData forKey:@"USER_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        
        NSLog(@"Clear  Tag : 2");
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/USER_INFO.txt", documentsDirectory];
        
        [sClear writeToFile:fullFileName atomically:NO encoding:NSUTF8StringEncoding error:nil];
        
    }
    
    [self ShowAlert:@"클리어 됐습니다."];
}

- (void)getData:(UserInfo*)tInfoData;

{
    
    [openView.view removeFromSuperview];
    [openView removeFromParentViewController];
    openView = nil;
    
//    [mutableArray addObject:@[value1,value2,value3]];
//    [mutableArray addObject:@[tInfoData.name, tInfoData.jender, tInfoData.phoneNum]];
    [mutableArray addObject:tInfoData];
    
    [tableView reloadData];
}

- (void)getEditData:(UserInfo*)tInfoData;

{
    
    [openView.view removeFromSuperview];
    [openView removeFromParentViewController];
    openView = nil;
    
    
//    [mutableArray insertObject:@[value1,value2,value3] atIndex:selectTableindex];
//    [mutableArray replaceObjectAtIndex:selectTableindex withObject:@[tInfoData.name, tInfoData.jender, tInfoData.phoneNum]];
    [mutableArray replaceObjectAtIndex:selectTableindex withObject:tInfoData];
    
    [numBox setText:@""];
    [nameBox setText:@""];
    [jenderBox setText:@""];
    
    userInfo = nil;
    
    [tableView reloadData];
}
    
- (void)CloseScreen{
    [openView.view removeFromSuperview];
    [openView removeFromParentViewController];
    openView = nil;
}
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
//    NSString *sName = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:0];
//    NSString *sJender = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:1];
//    NSString *sNum = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:2];
    
    selectTableindex = indexPath.row;
    
    UserInfo *info = [mutableArray objectAtIndex:selectTableindex];
    
    [nameBox setText:info.name];
    [jenderBox setText:info.jender];
    [numBox setText: [self MaskingPhoneNum:info.phoneNum]];
    
    userInfo = [[UserInfo alloc]init];
    
    [userInfo setName:info.name];
    [userInfo setJender:info.jender];
    [userInfo setPhoneNum:info.phoneNum];
    
}

-(void)ShowAlert:(NSString*)sContent;
{
    //팝업구현을 하는 클래스

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"알림" message:sContent preferredStyle:UIAlertControllerStyleAlert];
    //팝업 버튼 구현하는 클래스

    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
    //팝업 클래스에 버튼을 넣는 메소드 호출
    [alert addAction:closeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSString*) MaskingPhoneNum:sNum{
    // 마스킹을 시작하자 뚝딱 뚝딱
    
    NSString *sFrontNum;
    NSString *sMidNum;
    NSString *sEndNum;
    NSString *sMaskingNum;
    
    NSInteger nCnt = [sNum length];
    
    if (nCnt == 11) {
        sFrontNum = [sNum substringToIndex : 3];
        sMidNum = [[sNum substringFromIndex : 3] substringToIndex : 4];
        sEndNum = [sNum substringFromIndex : 7];

        sMaskingNum = [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
    }
    else{
        sFrontNum = [sNum substringToIndex : 3];
        sMidNum = [[sNum substringFromIndex : 3] substringToIndex : 3];
        sEndNum = [sNum substringFromIndex : 6];
        
        sMaskingNum = [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
    }
    
    return sMaskingNum;
}

-(void) dealloc{
    NSLog(@"ViewUserInfo Screen dealloc");
    
    [tableView removeFromSuperview];
    
    [nameBox removeFromSuperview];
    [jenderBox removeFromSuperview];
    [numBox removeFromSuperview];
    
    [self CloseNilProc:tableView];
    
    [self CloseNilProc:nameBox];
    
    [self CloseNilProc:jenderBox];
    [self CloseNilProc:numBox];
    
    [self CloseNilProc:openView];
    [self CloseNilProc:userInfo];
    
    [self CloseNilProc:mutableArray];
    
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}

@end
