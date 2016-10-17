

#import <UIKit/UIKit.h>

@protocol KDGuillotineMenuDelegate;

typedef NS_ENUM(NSUInteger, KDGuillotineMenuStyle) {
	KDGuillotineMenuStyleTable,
	KDGuillotineMenuStyleCollection,
};

@interface KDGuillotineMenu : UIViewController <UITableViewDataSource, UITableViewDelegate, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    
    float screenW;
    float screenH;
    
    float navBarH;
    float statusBarH;
    
    UIView      *menuView;
    UIButton    *menuButton;
    UITableView *menuTableView;
	UICollectionView *menuCollectionView;
    
    // - Menu Button Rotation
    float oldAngle;
    float currentAngle;
    
    
    BOOL isOpen;
    BOOL supportBoundaryAdded;
    
    UIPushBehavior *pushInit;
    UIPushBehavior *pushOpen;
    UIAttachmentBehavior *attachmentBehavior;
    
    // - Dynamics
    UIDynamicAnimator   *animator;
    UICollisionBehavior *collision;
    UIGravityBehavior   *gravity;
    
    CGPoint puntoAncoraggio;
    
    BOOL isPresentedFirst;
}

@property (nonatomic, strong) UIViewController  *currentViewController;

@property (nonatomic, strong) UIButton  *menuButton;
@property (nonatomic, strong) NSArray   *viewControllers;
@property (nonatomic, strong) NSArray   *menuTitles;
@property (nonatomic, strong) NSArray   *imagesTitles;
@property (nonatomic, strong) UIColor   *menuColor;
@property (nonatomic) KDGuillotineMenuStyle menuStyle;

@property (nonatomic, weak) id<KDGuillotineMenuDelegate> delegate;


// -Init method
- (id)initWithViewControllers:(NSArray *)vCs MenuTitles:(NSArray *)titles andImagesTitles:(NSArray *)imgTitles;
- (id)initWithViewControllers:(NSArray *)vCs MenuTitles:(NSArray *)titles andImagesTitles:(NSArray *)imgTitles andStyle:(KDGuillotineMenuStyle)style;

// -
- (BOOL)isOpen;

// -
- (void)switchMenuState;
- (void)openMenu;
- (void)dismissMenu;

@end

@protocol KDGuillotineMenuDelegate <NSObject>

- (void)menuDidOpen;
- (void)menuDidClose;
- (void)selectedMenuItemAtIndex:(NSInteger)index;

@end