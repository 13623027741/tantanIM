
#import "XMGInputView.h"


@interface XMGInputView ()
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *inputStyleBtn;

@end

@implementation XMGInputView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    UIImage* image = [XMGInputView yf_imageWithColor: [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]];
    [self.voiceBtn setBackgroundImage:image forState: UIControlStateNormal];
    self.voiceBtn.layer.borderWidth = 0.5;
    self.voiceBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.voiceBtn.layer.cornerRadius = 5;
    self.voiceBtn.hidden = YES;
}

+ (instancetype)xmg_inputView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (IBAction)changeInputStyle:(UIButton *)sender {
    // 通过voice按钮的hidden来控制输入方式的切换
    self.voiceBtn.hidden = sender.isSelected;
    sender.selected = !sender.isSelected;
    // 通过代理控制键盘回退
    self.voiceBtn.hidden ? [self.textField becomeFirstResponder]: [self.textField resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:changeInputStyle:)]) {
        [self.delegate xmg_inputView:self changeInputStyle:(self.voiceBtn.isHidden ? XMGInputStyleText: XMGInputStyleVoice)];
    }
}

- (IBAction)moreBtnClick:(id)sender {
    // 1.如果textField是编辑样式,那就取消它的编辑状态
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
    
    // 2.根据下方keyboard的高度(控制器.view的y值,来确定它的滑入滑出状态)
    
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:moreBtnClickWith:)]) {
        [self.delegate xmg_inputView:self moreBtnClickWith:0];
    }
    
    // 需要注意的是,设计到textfield是否是第一响应者时,注意其执行的先后顺序即可
    if (!self.voiceBtn.isHidden) {
        // 修改输入方式
        [self changeInputStyle: self.inputStyleBtn];
    }
}
- (IBAction)empressOnClick:(id)sender {
}


- (IBAction)voiceTouchDown:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:changeVoiceStatus:)]) {
        [self.delegate xmg_inputView:self changeVoiceStatus: XMGVoiceStatusSpeaking];
    }
}
- (IBAction)voiceTouchUpInside {
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:changeVoiceStatus:)]) {
        [self.delegate xmg_inputView:self changeVoiceStatus: XMGVoiceStatusSend];
    }
}
- (IBAction)voiceTouchDragOucside {
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:changeVoiceStatus:)]) {
        [self.delegate xmg_inputView:self changeVoiceStatus: XMGVoiceStatusWillCancle];
    }
}
- (IBAction)voiceTouchUpOutside {
    if ([self.delegate respondsToSelector:@selector(xmg_inputView:changeVoiceStatus:)]) {
        [self.delegate xmg_inputView:self changeVoiceStatus: XMGVoiceStatusCancled];
    }
}

+ (UIImage *)yf_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


@end
