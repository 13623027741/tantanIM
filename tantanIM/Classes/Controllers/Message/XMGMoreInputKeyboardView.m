

#import "XMGMoreInputKeyboardView.h"

@interface XMGMoreInputKeyboardView ()

/** 添加的btn */
@property (nonatomic, strong) NSMutableArray *btns;
/** 按钮标题系列 */
@property (nonatomic, strong) NSArray *btnTitles;

@end

@implementation XMGMoreInputKeyboardView

- (NSArray *)btnTitles
{
    if (!_btnTitles) {
        _btnTitles = @[ XMGPhotoInputStr, XMGVoiceVideoInputStr];
    }
    return _btnTitles;
}
- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        // 添加子控件
        for (NSString *title in self.btnTitles) {
            [self xmg_setBtnWithTitle: title];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 60;
    CGFloat btnH = btnW;
    CGFloat orx = 10;
    CGFloat ory = 10;
    
    NSInteger maxRowCount = 2;
    NSInteger maxColCount = 4;
    CGFloat colMargin = (CGRectGetWidth(self.bounds) - 2 * orx - maxColCount * btnW) / (maxColCount + 1);
    CGFloat rowMargin = (CGRectGetHeight(self.bounds) - 2 * ory - maxRowCount * btnH) / (maxColCount + 1);
    
    NSInteger index = 0;
    for (UIButton *btn in self.btns) {
        
        if (index < (maxColCount * maxRowCount)) {
            //
            NSInteger col = index % maxColCount;
            NSInteger row = index / maxColCount;
            btn.frame = CGRectMake(orx + col * (btnW + colMargin), (ory + row * (btnH + rowMargin)), btnW, btnH);
            
        }
        
        index ++;
    }
}

#pragma mark - 添加按钮
- (void)xmg_setBtnWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [btn addTarget:self action:@selector(moreInputBtnClick:) forControlEvents: UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
}

- (void)moreInputBtnClick: (UIButton *)btn
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    if(self.btnClickBlock)
    {
        
        self.btnClickBlock(btn);
    }
}

@end
