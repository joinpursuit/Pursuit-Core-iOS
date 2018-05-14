# iOS Development in Objective-C

## Objectives

Build tic-tac-toe

1. Create UI elements programmatically
2. Build models in Objective-C
3. Use View Controllers to manage views and communicate with

## 1. Configuring the App Delegate

Building apps in Objective-C, is very similar to Swift.  Simply select Objective-C instead of Swift when creating a new project.  You will notice that each file has a .m and a .h componenet which we can use for specifying the implementation and the interface.

We will be building the app without Storyboards, so we'll need to have the App Delegate create an instance of our View Controller.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *vc = [[ViewController alloc] init];
    _window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [_window setRootViewController:vc];
    [_window makeKeyAndVisible];
    return YES;
}
```


## 2. Building the Model

GameBrain.h

```objective-c
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GameStatus) {
    GameStatus_InProgress,
    GameStatus_InvalidMove,
    GameStatus_Tie,
    GameStatus_PlayerOneVictory,
    GameStatus_PlayerTwoVictory
};

@interface GameBrain : NSObject

@property (assign) BOOL isPlayerOneTurn;
@property (strong) NSMutableArray* gameBoard;


-(id)init;
-(GameStatus) makeMoveAtX: (int) x andY: (int) y;


@end
```

GameBrain.m

```objective-c
@implementation GameBrain

-(id) init {
    self = [super init];
    if (self) {
        _isPlayerOneTurn = YES;
        _gameBoard = [[NSMutableArray alloc] initWithArray:
                    @[
                       [[NSMutableArray alloc] initWithArray: @[@0, @0, @0]],
                       [[NSMutableArray alloc] initWithArray: @[@0, @0, @0]],
                       [[NSMutableArray alloc] initWithArray: @[@0, @0, @0]]
                      ]
                      ];
    }
    return self;
}

- (GameStatus)makeMoveAtX:(int)x andY:(int)y {
    if ((x > 2) || y > 2) {
        NSLog(@"User was able to select an invalid space.  This shouldn't happen");
        return GameStatus_InProgress;
    }
    if (![self.gameBoard[x][y] isEqual: @0]) {
        //Space is occuppied
        return GameStatus_InProgress;
    }
    if (self.isPlayerOneTurn) {
        self.gameBoard[x][y] = @1;
    } else {
        self.gameBoard[x][y] = @2;
    }
    NSLog(@"%@", self.gameBoard);
    self.isPlayerOneTurn = !self.isPlayerOneTurn;
    return [self victoryCheck];
}

-(GameStatus) victoryCheck {
    //Rows
    for (NSArray* row in self.gameBoard) {
        if ([row isEqual: @[@1,@1,@1]])
            return GameStatus_PlayerOneVictory;
        if ([row isEqual:@[@2,@2,@2]])
            return GameStatus_PlayerTwoVictory;
    }
    //Columns
    for (int i = 0; i < 3; i++){
        NSMutableArray *column = [[NSMutableArray alloc] init];
        for (int j = 0; j < 3; j++) {
            [column addObject:self.gameBoard[j][i]];
        }
        if ([column isEqual: @[@1,@1,@1]])
            return GameStatus_PlayerOneVictory;
        if ([column isEqual: @[@2,@2,@2]])
            return GameStatus_PlayerTwoVictory;
    }
    //Diag
    NSMutableArray *diagOne = [[NSMutableArray alloc] init];
    NSMutableArray *diagTwo = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        [diagOne addObject:self.gameBoard[i][i]];
        [diagTwo addObject:self.gameBoard[i][self.gameBoard.count - 1 - i]];
    }
    if ([diagOne isEqual:@[@1,@1,@1]] || [diagTwo isEqual:@[@1,@1,@1]])
        return GameStatus_PlayerOneVictory;
    if ([diagOne isEqual:@[@2,@2,@2]] || [diagTwo isEqual:@[@2,@2,@2]])
        return GameStatus_PlayerTwoVictory;
    //Ties
    BOOL containsEmptySpaces = NO;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if ([self.gameBoard[i][j] intValue] == 0) {
                containsEmptySpaces = YES;
                break;
            }
        }
    }
    if (containsEmptySpaces)
        return GameStatus_InProgress;
    return GameStatus_Tie;
}

@end
```

## Building the View Controller

ViewController.h

```objective-c
#import <UIKit/UIKit.h>
#import "GameBrain.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) GameBrain *gameBrain;
@property (strong, nonatomic) UIStackView *gameStackView;
@property (strong, nonatomic) UILabel *gameDescriptionLabel;
@property (strong, nonatomic) UIButton *resetGameButton;

@end
```

ViewController.m

```objective-c
#import "ViewController.h"
#import "UIView+borders.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameBrain = [[GameBrain alloc] init];
    [self allocInitSubviews];
    [self addSubviews];
    [self configureConstraints];
    [self.view setBackgroundColor:[UIColor cyanColor]];
}

-(void)allocInitSubviews {
    self.gameStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.gameDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.gameDescriptionLabel setText:@"Player One's Turn"];
    self.resetGameButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.resetGameButton setTitle:@"Reset Game" forState:UIControlStateNormal];
}

-(void)addSubviews {
    [self configureGameStackView];
    [self.view addSubview:self.gameStackView];
    [self.view addSubview:self.gameDescriptionLabel];
    [self.view addSubview:self.resetGameButton];
    [self.resetGameButton addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
    [self.resetGameButton setHidden:YES];
}

-(void) configureGameStackView {
    UIStackView *svOne = [self createButtonStackViewStartingAt: 0];
    UIStackView *svTwo = [self createButtonStackViewStartingAt: 3];
    UIStackView *svThree = [self createButtonStackViewStartingAt: 6];
    [self.gameStackView setAxis:UILayoutConstraintAxisVertical];
    [self.gameStackView setDistribution:UIStackViewDistributionFillEqually];
    [self.gameStackView addArrangedSubview:svOne];
    [self.gameStackView addArrangedSubview:svTwo];
    [self.gameStackView addArrangedSubview:svThree];
    [svOne addBottomBorderWithColor:UIColor.blackColor andWidth:5];
    [svThree addTopBorderWithColor:UIColor.blackColor andWidth:5];
}

-(UIStackView*) createButtonStackViewStartingAt: (int) val {
    UIStackView *sv = [[UIStackView alloc] init];
    [sv setAxis:UILayoutConstraintAxisHorizontal];
    [sv setDistribution:UIStackViewDistributionFillEqually];
    NSLog(@"val: %d", val);
    for (int i = val; i < val + 3; i ++) {
        UIButton *but = [[UIButton alloc] init];
        [but setTag:i];
        [but setTitle:@" - " forState:UIControlStateNormal];
        [but setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [but setBackgroundColor:UIColor.whiteColor];
        [but addTarget:self action:@selector(handleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (i != val + 2)
            [but addRightBorderWithColor:UIColor.blackColor andWidth:5];
        [sv addArrangedSubview:but];
    }
    return sv;
}

-(void)configureConstraints {
    [self.gameStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.gameStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.gameStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.gameStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5] setActive:YES];
    [[self.gameStackView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.5] setActive:YES];
    
    [self.gameDescriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.gameDescriptionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.gameDescriptionLabel.bottomAnchor constraintEqualToAnchor:self.gameStackView.topAnchor constant:-50] setActive:YES];
    
    [self.resetGameButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.resetGameButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.resetGameButton.topAnchor constraintEqualToAnchor:self.gameStackView.bottomAnchor constant:50] setActive:YES];
}

-(void)handleButtonPressed:(UIButton *)button {
    //NSLog(@"Button Pressed with tag %ld", (long)button.tag);
    int x = 0;
    int y;
    if ((int)button.tag < 3) {
        x = 0;
    } else if ((int)button.tag < 6) {
        x = 1;
    } else if ((int)button.tag < 9)
        x = 2;
    y = (int)button.tag % 3;
    GameStatus status = [self.gameBrain makeMoveAtX:x andY:y];
    if (status != GameStatus_InvalidMove) {
        NSString *str = @"";
        if (self.gameBrain.isPlayerOneTurn) {
            str = @"O";
            [self.gameDescriptionLabel setText:@"Player One's Turn"];
        } else {
            str = @"X";
            [self.gameDescriptionLabel setText:@"Player Two's Turn"];
        }
        [button setTitle:str forState:UIControlStateNormal];
    }
    switch (status) {
        case GameStatus_InvalidMove:
            NSLog(@"Invalid Move");
            break;
        case GameStatus_Tie:
            [self.gameDescriptionLabel setText:@"Tie Game!"];
            [self lockGame];
            break;
        case GameStatus_InProgress:
            NSLog(@"In Progress");
            break;
        case GameStatus_PlayerOneVictory:
            [self.gameDescriptionLabel setText:@"Player One Wins!"];
            [self lockGame];
            break;
        case GameStatus_PlayerTwoVictory:
            [self.gameDescriptionLabel setText:@"Player Two Wins!"];
            [self lockGame];
            break;
    }
}

-(void) lockGame {
    for (UIStackView *sv in self.gameStackView.subviews) {
        for (UIButton *but in sv.subviews) {
            [but setEnabled:NO];
        }
    }
    [self.resetGameButton setHidden:NO];
}

-(void) resetGame {
    for (UIStackView *sv in self.gameStackView.subviews) {
        for (UIButton *but in sv.subviews) {
            if ([but isKindOfClass:[UIButton class]]) {
                [but setTitle:@"-" forState:UIControlStateNormal];
                [but setEnabled:YES];
            }
        }
    }
    [self.gameDescriptionLabel setText:@"Player One's Turn"];
    [self.resetGameButton setHidden:YES];
    self.gameBrain = [[GameBrain alloc] init];
}

@end
```

UIView+borders.h

```objective-c
#import <UIKit/UIKit.h>

//https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview?answertab=votes#tab-top

@interface UIView (borders)
- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

@end

```

UIView+borders.m

```objective-c
#import "UIView+borders.h"

@implementation UIView (borders)
- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self addSubview:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self addSubview:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [border setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin];
    [self addSubview:border];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [UIView new];
    border.backgroundColor = color;
    [border setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin];
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self addSubview:border];
}
@end
```