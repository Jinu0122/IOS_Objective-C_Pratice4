//
//  ViewUserInfo.h
//  SecondTask
//
//  Created by Jinwoo on 2023/06/22.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ViewUserInfoDelefate <NSObject>

- (void)getData:(UserInfo*)value;
- (void)getEditData:(UserInfo*)value;
- (void)CloseScreen;


@end

@interface ViewUserInfo : UIViewController <UITextFieldDelegate>
{
//    id<ViewUserInfoDelefate> delegate;
}


@property ( nonatomic , weak  ) id<ViewUserInfoDelefate> delegate;
@property ( nonatomic, strong)  UserInfo *userInfo;

@end

NS_ASSUME_NONNULL_END
