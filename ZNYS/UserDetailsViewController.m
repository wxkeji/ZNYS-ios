//
//  UserDetailsViewController.m
//  ZNYS
//
//  Created by yu243e on 16/12/23.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UserCollectionViewCell.h"
#import "UserManager.h"
#import "User+CoreDataClass.h"
#import "MyUserDetailsView.h"

typedef NS_ENUM(NSInteger, ZNYSUserDetailsButtonState) {
    ZNYSUserDetailsButtonStateUnspecified   = 0,
    ZNYSUserDetailsButtonStateClose,
    ZNYSUserDetailsButtonStateConfirm
};

@interface UserDetailsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *topContentView;
@property (nonatomic, strong) UIButton *closeOrConfirmButton;
@property (nonatomic, strong) MyUserDetailsView *userDetailsView;

@property (nonatomic, strong) UIImageView *switcherView;
@property (nonatomic, strong) UICollectionView *switchCollectionView;
@property (nonatomic, assign) NSIndexPath *selectedIndexPath;

@property (nonatomic, assign) ZNYSUserDetailsButtonState buttonState;   //button 状态
@property (nonatomic, assign) BOOL hasSwitchView;   //是否有两个用户

@property (nonatomic, strong) NSIndexPath *selectedUserIndex;    //选择的用户

@end

static const CGFloat mainHeight = 250;
static const CGFloat switcherHeight = 100;

static NSString * const userCellID = @"userCell";

static NSTimeInterval swichAnimationTime = 0.3;

@implementation UserDetailsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTheme];
    
    self.hasSwitchView = [self judgeSwitchView];    //初始化时判断一次
    if (self.hasSwitchView) {
        [self.contentView addSubview:self.switcherView];
        self.switcherView.userInteractionEnabled = YES;
        [self.switcherView addSubview:self.switchCollectionView];
        self.switchCollectionView.delegate = self;
        self.switchCollectionView.dataSource = self;
        [self.switchCollectionView registerNib:[UINib nibWithNibName:@"UserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:userCellID];
    }
    
    [self updatePreferredContentSize];  //更新UIViewConroller.view的 size
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topContentView];
    self.topContentView.userInteractionEnabled = YES;
    
    [self.topContentView addSubview:self.userDetailsView];
    
    [self.topContentView addSubview:self.closeOrConfirmButton];
    [self settingButtonState:ZNYSUserDetailsButtonStateClose animated:NO];
    [self.closeOrConfirmButton addTarget:self action:@selector(closeOrConfirmButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupConstraintsForSubviews];
    
    [self showUserDetails:[[UserManager sharedInstance] currentUser] animated:YES];
}
- (void)updatePreferredContentSize {
    CGFloat contentSizeWidth = kSCREEN_WIDTH;
    CGFloat contentSizeHeight = mainHeight + self.hasSwitchView * switcherHeight;
    
    self.preferredContentSize = CGSizeMake(contentSizeWidth, contentSizeHeight);
}


- (void)setupConstraintsForSubviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight + switcherHeight);
    }];
    
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight);
    }];
    [self.userDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight);
    }];
    [self.closeOrConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-MIN_EDGE_X);
        make.top.equalTo(self.topContentView.mas_top).offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    if (self.hasSwitchView) {
        [self.switcherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(mainHeight);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(switcherHeight);
        }];
        
        [self.switchCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.switcherView.mas_top);
            make.left.equalTo(self.switcherView.mas_left);
            make.right.equalTo(self.switcherView.mas_right);
            make.height.mas_equalTo(switcherHeight);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedIndexPath isEqual:indexPath]) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [self showUserDetails:[[UserManager sharedInstance] currentUser] animated:YES];
        [self settingButtonState:ZNYSUserDetailsButtonStateClose animated:YES];
        self.selectedIndexPath = nil;
    } else {
        [self showUserDetails:[[UserManager sharedInstance] allUsersExceptUUID:nil][indexPath.row] animated:YES];
        //记录选中的 user 位置
        self.selectedUserIndex = indexPath;
        
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self settingButtonState:ZNYSUserDetailsButtonStateConfirm animated:YES];
        self.selectedIndexPath = indexPath;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[UserManager sharedInstance] currentUserCount] - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCollectionViewCell *cell = (UserCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:userCellID forIndexPath:indexPath];
    
    User *user = (User *)[[UserManager sharedInstance] allUsersExceptUUID:nil][indexPath.row];
    
    [cell.userImageView setImage:[UserManager UserAvatarImageWithUser:user]];
    [cell.userNameLabel setText:user.nickName];
    
    return cell;
}

#pragma mark - event response
- (void)closeOrConfirmButtonTap {
    switch (self.buttonState) {
        case ZNYSUserDetailsButtonStateConfirm:
            [[UserManager sharedInstance] changeCurrentUser:[[UserManager sharedInstance] allUsersExceptUUID:nil][self.selectedUserIndex.row]];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
    }
}
#pragma mark - private methods
- (void)configureTheme {
    self.view.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
}
- (BOOL)judgeSwitchView {
    return [[UserManager sharedInstance] currentUserCount] > 1;
}
- (void)showUserDetails:(User *)user animated:(BOOL)flag {
    if (flag == NO) {
        //BUG 不能为NO
        self.userDetailsView = [self userDetailsViewWithUser:user];
        return;
    }
    MyUserDetailsView *fromView = self.userDetailsView;
    MyUserDetailsView *toView = [self userDetailsViewWithUser:user];
    self.userDetailsView = toView;
    toView.frame = fromView.frame;
    toView.alpha = 0.f;
    [self.topContentView insertSubview:toView aboveSubview:fromView];
    [UIView animateWithDuration:swichAnimationTime animations:^{
        fromView.alpha = 0.2f;
        toView.alpha = 1.f;
        [self configureTheme];
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
    }];
}
- (MyUserDetailsView *)userDetailsViewWithUser:(User *)user {
    //+++ temp todo 未完成
//    if (user.uuid != [[UserManager sharedInstance] currentUserUUID]) {
//        [[ThemeManager sharedManager] configureTheme:ZNYSThemeStylePink];
//    } else {
//        [[ThemeManager sharedManager] configureTheme:ZNYSThemeStyleBlue];
//    }
    MyUserDetailsView *tempUserDetailsView = [MyUserDetailsView loadViewFromNib];
    [tempUserDetailsView.userImageView setImage:[UserManager UserAvatarImageWithUser:user]];
    [tempUserDetailsView.userNameLabel setText:user.nickName];
    [tempUserDetailsView.levelLabel setText:[NSString stringWithFormat:@"%d",user.level]];
    [tempUserDetailsView.coinLabel setText:[NSString stringWithFormat:@"%@", @(user.tokensOwned)]];
    
    return tempUserDetailsView;
}
- (void)settingButtonState:(ZNYSUserDetailsButtonState)buttonState animated:(BOOL)flag  {
    BOOL animationFlag = flag;
    if (self.buttonState == ZNYSUserDetailsButtonStateUnspecified) {
        animationFlag = NO;
    }
    if (self.buttonState != buttonState) {
        self.buttonState = buttonState;
        [UIView transitionWithView:self.closeOrConfirmButton
                           duration:swichAnimationTime * animationFlag
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                            switch (self.buttonState) {
                                case ZNYSUserDetailsButtonStateConfirm:
                                    [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/confirm"] forState:UIControlStateNormal];
                                    break;
                                case ZNYSUserDetailsButtonStateUnspecified:
                                    // no break
                                case ZNYSUserDetailsButtonStateClose:
                                    [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/close"] forState:UIControlStateNormal];
                                    break;
                            }
                         } completion:NULL];
    }
}

#pragma mark - getters and setters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIImageView alloc] init];
        _topContentView.backgroundColor = [UIColor clearColor];
    }
    return _topContentView;
}
- (UIImageView *)switcherView {
    if (!_switcherView) {
        _switcherView = [[UIImageView alloc] init];
        _switcherView.opaque = NO;
        //用遮障模拟浅色 primary Color 可以尝试？
        _switcherView.backgroundColor = RGBACOLOR(255, 255, 255, 0.33);
    }
    return _switcherView;
}
- (UIScrollView *)switchCollectionView {
    if (!_switchCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(80, switcherHeight);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _switchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _switchCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _switchCollectionView;
}
- (MyUserDetailsView *)userDetailsView {
    if (!_userDetailsView) {
        _userDetailsView = [MyUserDetailsView loadViewFromNib];
    }
    return _userDetailsView;
}
- (UIButton *)closeOrConfirmButton {
    if (!_closeOrConfirmButton) {
        _closeOrConfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _closeOrConfirmButton;
}

@end
