## Demo - MVC, Autolayout

In this Objective-C Demo app we will use MVC principles to build a Tip calculator. We will use programmatic autolayout to size and position the UIView elements in the app. 

## Model 
**Tip**
A tip object has a bill and the percent allocated to the bill, i.e 10%, 15% or 20% accordingly. 

```objective-c
typedef NS_ENUM(NSInteger, TipPercent) {
    Percent10 = 10,
    Percent15 = 15,
    Percent20 = 20
};

@interface Tip: NSObject
@property (assign) double bill;
@property (nonatomic) TipPercent percent;
@end
```

## View

Here we will sublcass UIView to create a TipView which will consists of the calculator elements. A UIStackView will be used to arrange the tip percent labels horizontally onscreen. 

**TipView.h**

```objective-c
@interface TipView : UIView

@property (nonatomic) UIImageView *imageView;

@property (nonatomic) UILabel *tenPercentValue;
@property (nonatomic) UILabel *fifteenPercentValue;
@property (nonatomic) UILabel *twentyPercentValue;

@property (nonatomic) UILabel *tenPercentLabel;
@property (nonatomic) UILabel *fifteenPercentLabel;
@property (nonatomic) UILabel *twentyPercentLabel;

@property (nonatomic) UILabel *billLabel;
@property (nonatomic) UITextField *billTextField;

@property (nonatomic) UIButton *calculateTipButton; 

@property (nonatomic) UIStackView *stackView;

- (void)updateTipValuesTenPercent: (double)tenPercent
                   fifteenPercent: (double)fifteenPercent
                    twentyPercent: (double)twentyPercent;

@end
```

**TipView.m**


```objective-c
#import "TipView.h"

#define PADDING 20

@interface TipView ()
// private properties / methods here
@end

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor orangeColor];
    [self setupImageView];
    [self setupStackView];
    [self setupTenPercentLabel];
    [self setupFifteenPercentLabel];
    [self setupTwentyPercentLabel];
    [self setupBillLabel];
    [self setupBillTextField];
    [self setupCalculateBillButton];
}

- (void)setupImageView {
    // Lazy Initialization
    if (!_imageView)
        _imageView = [[UIImageView alloc] init];
    
    // Add attributes needed for UIView
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:[UIImage imageNamed:@"tip-icon"]];
    self.imageView.backgroundColor = [UIColor whiteColor];
    
    // Add View to hierarchy
    [self addSubview:self.imageView];
    
    // Setup Constraints
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.imageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.30],
        [self.imageView.widthAnchor constraintEqualToAnchor:self.imageView.heightAnchor]
    ]];
}

- (void)setupStackView {
    if(!_stackView)
        _stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.spacing = PADDING;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    
    [self addSubview:self.stackView];

    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant: PADDING],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant: PADDING],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -PADDING],
        [self.stackView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.10]
    ]];
    
    if(!_tenPercentValue)
        _tenPercentValue = [[UILabel alloc] init];
    self.tenPercentValue.text = @"$0.00";
    self.tenPercentValue.textAlignment = NSTextAlignmentCenter;
    self.tenPercentValue.backgroundColor = [UIColor redColor];
    
    if(!_fifteenPercentValue)
        _fifteenPercentValue = [[UILabel alloc] init];
    self.fifteenPercentValue.text = @"$0.00";
    self.fifteenPercentValue.textAlignment = NSTextAlignmentCenter;
    self.fifteenPercentValue.backgroundColor = [UIColor greenColor];
    
    if(!_twentyPercentValue)
        _twentyPercentValue = [[UILabel alloc] init];
    self.twentyPercentValue.text = @"$0.00";
    self.twentyPercentValue.textAlignment = NSTextAlignmentCenter;
    self.twentyPercentValue.backgroundColor = [UIColor yellowColor];
    
    [self.stackView addArrangedSubview:self.tenPercentValue];
    [self.stackView addArrangedSubview:self.fifteenPercentValue];
    [self.stackView addArrangedSubview:self.twentyPercentValue];
}

- (void)setupTenPercentLabel {
    if(!_tenPercentLabel)
        _tenPercentLabel = [[UILabel alloc] init];
    self.tenPercentLabel.text = @"10%";
    self.tenPercentLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: self.tenPercentLabel];
    
    self.tenPercentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tenPercentLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor constant: PADDING / 2.0],
        [self.tenPercentLabel.centerXAnchor constraintEqualToAnchor:self.tenPercentValue.centerXAnchor]
    ]];
}

- (void)setupFifteenPercentLabel {
    if(!_fifteenPercentLabel)
        _fifteenPercentLabel = [[UILabel alloc] init];
    self.fifteenPercentLabel.text = @"15%";
    self.fifteenPercentLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: self.fifteenPercentLabel];
    
    self.fifteenPercentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.fifteenPercentLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor constant: PADDING / 2.0],
                                              [self.fifteenPercentLabel.centerXAnchor constraintEqualToAnchor:self.fifteenPercentValue.centerXAnchor]
                                              ]];
}

- (void)setupTwentyPercentLabel {
    if(!_twentyPercentLabel)
        _twentyPercentLabel = [[UILabel alloc] init];
    
    self.twentyPercentLabel.text = @"20%";
    self.twentyPercentLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: self.twentyPercentLabel];
    
    self.twentyPercentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.twentyPercentLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor constant: PADDING / 2.0],
                                              [self.twentyPercentLabel.centerXAnchor constraintEqualToAnchor:self.twentyPercentValue.centerXAnchor]
    ]];
}

- (void)setupBillLabel {
    if(!_billLabel)
        _billLabel = [[UILabel alloc] init];
    
    self.billLabel.text = @"Your Bill";
    self.billLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview: self.billLabel];
    
    self.billLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.billLabel.topAnchor constraintEqualToAnchor: self.tenPercentLabel.bottomAnchor constant: PADDING],
        [self.billLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:PADDING]
    ]];
}

- (void)setupBillTextField {
    if(!_billTextField)
        _billTextField = [[UITextField alloc] init];
    
    self.billTextField.text = @"$0.00";
    self.billTextField.textAlignment = NSTextAlignmentCenter;
    self.billTextField.backgroundColor = [UIColor whiteColor];
    self.billTextField.font = [UIFont systemFontOfSize:40 weight:UIFontWeightMedium];
    self.billTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.billTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 49)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.billTextField.inputAccessoryView = keyboardToolbar;
    [keyboardToolbar setItems:@[cancelButton, flexibleSpace, /*doneButton*/] animated:YES];
    [self addSubview:self.billTextField];
    
    self.billTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.billTextField.topAnchor constraintEqualToAnchor: self.billLabel.bottomAnchor constant: PADDING],
        [self.billTextField.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: PADDING],
        [self.billTextField.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -PADDING],
        [self.billTextField.heightAnchor constraintEqualToAnchor: self.heightAnchor multiplier: 0.15]
    ]];
}

- (void)setupCalculateBillButton {
    if(!_calculateTipButton)
        _calculateTipButton = [[UIButton alloc] init];

    [self.calculateTipButton setTitle:@"Calculate Tip" forState:UIControlStateNormal];
    self.calculateTipButton.backgroundColor = [UIColor yellowColor];
    [self.calculateTipButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self addSubview:self.calculateTipButton];
    
    self.calculateTipButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.calculateTipButton.topAnchor constraintEqualToAnchor:self.billTextField.bottomAnchor constant:PADDING],
        [self.calculateTipButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:PADDING],
        [self.calculateTipButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-PADDING],
        [self.calculateTipButton.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.15]
    ]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.height / 2.0;
}

- (void)updateTipValuesTenPercent:(double)tenPercent
                   fifteenPercent:(double)fifteenPercent
                    twentyPercent:(double)twentyPercent {
    self.tenPercentValue.text = [NSString stringWithFormat:@"$%1.2f", tenPercent];
    self.fifteenPercentValue.text = [NSString stringWithFormat:@"$%1.2f", fifteenPercent];
    self.twentyPercentValue.text = [NSString stringWithFormat:@"$%1.2f", twentyPercent];
}

- (void)cancel {
    [self.billTextField resignFirstResponder];
}

@end
```

## Controller
The TipController adds the tipView as its subview, calculates the Tip and manages the keyboard. 

> Reminder: In Objective-C sending messages to nil won't crash your app and this may lead to logic errors and take a longer time than needed when debugging. So always ensure that your properties are alloc, init as needed. 

**TipViewController.m**

```objective-c
#import "TipViewController.h"
#import "TipView.h"
#import "Tip.h"

@interface TipViewController ()
// private properties, methods
@property TipView *tipView;
@end

@implementation TipViewController

#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // lazy initialization
    if (!_tipView) {
        _tipView = [[TipView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        [self.view addSubview: _tipView];
        [_tipView.calculateTipButton addTarget:self action:@selector(calculateTip) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self registerForKeyboardNotifications];
}

#pragma mark Helper Methods
- (void)calculateTip {
    NSString *strippedValue = [self.tipView.billTextField.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
    self.tipView.billTextField.text = strippedValue;
    
    // resign textfield as first responder
    [self.tipView.billTextField resignFirstResponder];
    
    double value = [self.tipView.billTextField.text doubleValue];
    
    Tip *tenPercenttip = [[Tip alloc] init];
    tenPercenttip.bill = value;
    tenPercenttip.percent = Percent10;
    double tenPercent = tenPercenttip.bill * (tenPercenttip.percent / 100.0);
    
    Tip *fifteenPercenttip = [[Tip alloc] init];
    fifteenPercenttip.bill = value;
    fifteenPercenttip.percent = Percent15;
    double fifteenPercent = fifteenPercenttip.bill * (fifteenPercenttip.percent / 100.0);
    
    Tip *twentyPercenttip = [[Tip alloc] init];
    twentyPercenttip.bill = value;
    twentyPercenttip.percent = Percent20;
    double twentyPercent = twentyPercenttip.bill * (twentyPercenttip.percent / 100.0);

    NSLog(@"10%% tip is %1.2f \n", tenPercent);
    NSLog(@"15%% tip is %1.2f \n", fifteenPercent);
    NSLog(@"20%% tip is %1.2f \n", twentyPercent);
    
    [self.tipView updateTipValuesTenPercent:tenPercent
                                 fifteenPercent:fifteenPercent
                                  twentyPercent:twentyPercent];
    
    NSString *stringValue = [self.tipView.billTextField.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
    self.tipView.billTextField.text = [NSString stringWithFormat:@"$%@", stringValue];
}

#pragma mark Keyboard Handling
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow: (NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGSize size = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.tipView.transform = CGAffineTransformMakeTranslation(0, -size.height);
}

- (void)keyboardWillHide: (NSNotification *)notification {
    self.tipView.transform = CGAffineTransformIdentity;
}

@end
```

Above we manage the keyboard through NSNotificationCenter

**AppDelegate.m**

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if(!_window) {
        TipViewController *vc = [[TipViewController alloc] init];
        _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.rootViewController = vc;
        [_window makeKeyAndVisible]; 
    }
    
    return YES;
}
```

## Unit Test 

As developers we should always aim to have tests in our programs. Below is a simple set of tests to run against tip percentages base on our bill amount. 

```objective-c
#import <XCTest/XCTest.h>
#import "Tip.h"

@interface TipTests : XCTestCase

@end

@implementation TipTests

- (void)test10PercentTip {
    // setup
    Tip *tip = [[Tip alloc] init];
    tip.bill = 50.00;
    tip.percent = Percent10;
    double tipValue = tip.bill * (tip.percent / 100.0);

    // test
    XCTAssertEqual(tipValue, 5.00);
}

- (void)test15PercentTip {
    // setup
    Tip *tip = [[Tip alloc] init];
    tip.bill = 50.00;
    tip.percent = Percent15;
    double tipValue = tip.bill * (tip.percent / 100.0);
    
    // test
    XCTAssertEqual(tipValue, 7.50);
}

- (void)test20PercentTip {
    // setup
    Tip *tip = [[Tip alloc] init];
    tip.bill = 50.00;
    tip.percent = Percent20;
    double tipValue = tip.bill * (tip.percent / 100.0);
    
    // test
    XCTAssertEqual(tipValue, 10.00);
}

@end
```

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit9/MVC-AutoLayout/Images/tip-app-1.png" width="321" height="560"/>
</p>


Below an inputAccessoryView is used as a property on the UITextField to dismiss the keyboard.
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit9/MVC-AutoLayout/Images/tip-app-2.png" width="321" height="560"/>
</p>

