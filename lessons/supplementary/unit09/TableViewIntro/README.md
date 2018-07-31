# Tableviews and Delegation

## Objectives

Build a movie app with a tableview, search bar, and segues.

1. Create and configure a UITableView
2. Display custom cells to the user
3. Segue from a tableview cell to a detail view controller
4. Configure a search bar to filter movies


# Configure the app delegate

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MoviesViewController *moviesVC = [[MoviesViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] init];
    [navVC setViewControllers:@[moviesVC] animated:false];
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [_window setRootViewController:navVC];
    [_window makeKeyAndVisible];
    return YES;
}
```

# Building the model

**Movie.h**

```objective-c
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Genre) {
    Genre_Animation,
    Genre_Action,
    Genre_Drama
};

@interface Movie : NSObject

@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* longDescription;
@property (assign) int year;
@property (assign) Genre genre;

-(instancetype)initWithName: (NSString*) name andDescription:(NSString*) description andYear:(int) year andGenre:(Genre) genre;
-(NSString*) imageName;
+(NSArray*) testMovies;

@end
```


**Movie.m**

```objective-c

#import "Movie.h"

@implementation Movie

-(instancetype) initWithName:(NSString *)name andDescription:(NSString *)description andYear:(int)year andGenre:(Genre)genre {
    self = [super init];
    if (self) {
        _name = name;
        _longDescription = description;
        _year = year;
        _genre = genre;
    }
    return self;
}

-(NSString*) imageName {
    return [[self.name lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

+(NSArray*) testMovies {
    Movie *minions = [[Movie alloc] initWithName:@"Minions" andDescription:@"Evolving from single-celled yellow organisms at the dawn of time, Minions live to serve, but find themselves working for a continual series of unsuccessful masters, from T. Rex to Napoleon. Without a master to grovel for, the Minions fall into a deep depression. But one minion, Kevin, has a plan." andYear:2015 andGenre:Genre_Animation];
    Movie *shrek = [[Movie alloc] initWithName:@"Shrek" andDescription:@"Once upon a time, in a far away swamp, there lived an ogre named Shrek whose precious solitude is suddenly shattered by an invasion of annoying fairy tale characters. They were all banished from their kingdom by the evil Lord Farquaad. Determined to save their home -- not to mention his -- Shrek cuts a deal with Farquaad and sets out to rescue Princess Fiona to be Farquaad\"s bride. Rescuing the Princess may be small compared to her deep, dark secret." andYear:2001 andGenre:Genre_Animation];
    Movie *zootopia = [[Movie alloc] initWithName:@"Zootopia" andDescription:@"From the largest elephant to the smallest shrew, the city of Zootopia is a mammal metropolis where various animals live and thrive. When Judy Hopps becomes the first rabbit to join the police force, she quickly learns how tough it is to enforce the law." andYear:2016 andGenre:Genre_Animation];
    Movie *avatar = [[Movie alloc] initWithName:@"Avatar" andDescription:@"On the lush alien world of Pandora live the Na\"vi, beings who appear primitive but are highly evolved. Because the planet\"s environment is poisonous, human/Na\"vi hybrids, called Avatars, must link to human minds to allow for free movement on Pandora. Jake Sully, a paralyzed former Marine, becomes mobile again through one such Avatar and falls in love with a Na\"vi woman. As a bond with her grows, he is drawn into a battle for the survival of her world." andYear:2009 andGenre:Genre_Action];
    Movie *darkKnight = [[Movie alloc] initWithName:@"The Dark Knight" andDescription:@"With the help of allies Lt. Jim Gordon and DA Harvey Dent, Batman has been able to keep a tight lid on crime in Gotham City. But when a vile young criminal calling himself the Joker suddenly throws the town into chaos, the caped Crusader begins to tread a fine line between heroism and vigilantism." andYear:2008 andGenre:Genre_Action];
    Movie *transformers = [[Movie alloc] initWithName:@"Transformers" andDescription:@"The fate of humanity is at stake when two races of robots, the good Autobots and the villainous Decepticons, bring their war to Earth. The robots have the ability to change into different mechanical objects as they seek the key to ultimate power. Only a human youth, Sam Witwicky can save the world from total destruction." andYear:2007 andGenre:Genre_Action];
    Movie *titanic = [[Movie alloc] initWithName:@"Titanic" andDescription:@"The ill-fated maiden voyage of the R.M.S. Titanic; the pride and joy of the White Star Line and, at the time, the largest moving object ever built. She was the most luxurious liner of her era -- the \"ship of dreams\" -- which ultimately carried over 1,500 people to their death in the ice cold waters of the North Atlantic in the early hours of April 15, 1912." andYear:1997 andGenre:Genre_Drama];
    Movie *hungerGames = [[Movie alloc] initWithName:@"The Hunger Games" andDescription:@"Katniss Everdeen voluntarily takes her younger sister\"s place in the Hunger Games, a televised competition in which two teenagers from each of the twelve Districts of Panem are chosen at random to fight to the death." andYear:2012 andGenre:Genre_Drama];
    Movie *americanSniper = [[Movie alloc] initWithName:@"American Sniper" andDescription:@"Navy S.E.A.L. sniper Chris Kyle\"s pinpoint accuracy saves countless lives on the battlefield and turns him into a legend. Back home to his wife and kids after four tours of duty, however, Chris finds that it is the war he can\"t leave behind." andYear:2014 andGenre:Genre_Drama];
    return @[minions, shrek, zootopia, avatar, darkKnight,transformers,titanic,hungerGames,americanSniper];
}

@end
```

# Building the Movies View Controller

**MoviesViewController.h**

```objective-c

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *moviesTableView;
@property (strong, nonatomic) UISearchBar *movieSearchBar;
@property (strong, nonatomic) NSArray *movies;
@property (copy, nonatomic) NSString *searchTerm;

@end

```

**MoviesViewController.m**

```objective-c
#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "Movie.h"
#import "MovieDetailViewController.h"

#define CELLID "Movie Cell"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.cyanColor];
    [self allocInitSubviews];
    [self configureSubviews];
    [self addSubviews];
    [self configureConstraints];
    [self loadMovies];
}

-(void)allocInitSubviews {
    _moviesTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _movieSearchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
}

-(void)configureSubviews {
    [self configureTableView];
    [self configureSearchBar];
}

- (void)configureTableView {
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"MovieTableViewCell" bundle:nil];
    [self.moviesTableView registerNib:nib forCellReuseIdentifier:@CELLID];
    self.moviesTableView.rowHeight = UITableViewAutomaticDimension;
    self.moviesTableView.estimatedRowHeight = 200.0;
}

- (void)configureSearchBar {
    self.movieSearchBar.placeholder = @"Search for a movie!";
    self.movieSearchBar.delegate = self;
}

-(void)addSubviews {
    [self.view addSubview:self.moviesTableView];
    [self.view addSubview:self.movieSearchBar];
}

-(void)configureConstraints {
    self.movieSearchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.movieSearchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[self.movieSearchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.movieSearchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    
    self.moviesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.moviesTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.moviesTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.moviesTableView.topAnchor constraintEqualToAnchor:self.movieSearchBar.bottomAnchor] setActive:YES];
    [[self.moviesTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

-(void)loadMovies {
    self.movies = [Movie testMovies];
    [self.moviesTableView reloadData];
}

#pragma mark SearchBar Delegate Methods

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newString = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    self.searchTerm = newString;
    [self.moviesTableView reloadData];
    return YES;
}

#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie* selectedMovie = [self filteredMovies][indexPath.row];
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] initWithMovie:selectedMovie];
    [self.navigationController pushViewController:movieDetailVC animated:true];
}

#pragma mark TableView Data Source Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELLID forIndexPath:indexPath];
    if (cell) {
        Movie* movie;
        movie = [self filteredMovies][indexPath.row];
        [cell configureCellWithMovie:movie];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self filteredMovies].count;
}

- (NSArray*)filteredMovies {
    if (self.searchTerm != nil && !([self.searchTerm isEqualToString:@""])) {
        NSPredicate* pred = [NSPredicate predicateWithFormat:@"name CONTAINS %@", self.searchTerm];
        return [self.movies filteredArrayUsingPredicate:pred];
    } else {
        return self.movies;
    }
}

@end
```

# Building the MovieTableViewCell

**MovieTableViewCell.h**

```objective-c
#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void)configureCellWithMovie:(Movie*) movie;

@end
```

**MovieTableViewCell.m**

```objective-c
#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

-(void)configureCellWithMovie:(Movie *)movie {
    self.nameLabel.text = movie.name;
    self.descriptionLabel.text = movie.longDescription;
    self.yearLabel.text = [[NSString alloc] initWithFormat: @"%d",movie.year];
    self.movieImageView.image = [UIImage imageNamed:[movie imageName]];
}

@end
```


# Building the Movie Detail View Controller

**MovieDetailViewController.h**

```objective-c

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property (strong, nonatomic) Movie* movie;
@property (strong, nonatomic) UIImageView *movieImageView;

-(instancetype)initWithMovie: (Movie*) movie;

@end
```

**MovieDetailViewController.m**

```objective-c
#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

-(instancetype)initWithMovie:(Movie *)movie {
    self = [super init];
    if (self) {
        _movie = movie;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocInitSubviews];
    [self configureSubviews];
    [self addSubviews];
    [self configureConstraints];
}

- (void) allocInitSubviews {
    self.movieImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
}

- (void) configureSubviews {
    self.movieImageView.image = [UIImage imageNamed:[self.movie imageName]];
}

- (void) addSubviews {
    [self.view addSubview:self.movieImageView];
}

- (void) configureConstraints {
    self.movieImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.movieImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.movieImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.movieImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[self.movieImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

@end
```