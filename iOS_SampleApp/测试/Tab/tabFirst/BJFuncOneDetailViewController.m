//
//  BJFuncOneDetailViewController.m
//  iOS_SampleApp
//
//  Created by 蔡佰津 on 2018/10/30.
//  Copyright © 2018年 蔡佰津. All rights reserved.
//

#import "BJFuncOneDetailViewController.h"
#import "BaseHeader.h"
#import "BJSingleTest.h"

#define Label @"Label"
#define Button  @"Button"
#define TextField @"TextField"
#define Segmented_Control @"Segmented Control"
#define Slider @"Slider"
#define Switch @"Switch"
#define Activity_Indicator_View @"Activity Indicator View"
#define Progress_View @"Progress View"
#define Page_Control @"Page Control"
#define Stepper @"Stepper"
#define Text_View @"Text View"
#define Scroll_View @"Scroll View"
#define Date_Picker @"Date Picker"
#define Picker_View @"Picker View"
#define Table_View @"Table View"
#define Collection_View @"Collection View"
#define Search_Bar @"Search Bar"
#define Tab_Bar @"Tab Bar"

@interface BJFuncOneDetailViewController ()
{
    NSString *str;
}
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UISwitch *switchON;
//@property (nonatomic, strong) UIActivity
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;


@end

@implementation BJFuncOneDetailViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    [self inputSingleName];
    // Do any additional setup after loading the view.
}

- (void)inputSingleName {
    BJSingleTest *single = [BJSingleTest sharedInstance];
    single.name = @"徐野";
    NSLog(@"123");
}

- (void)setUpUI {
    if ([_type isEqualToString:Label]) {
        self.label.center = self.view.center;
        [self createLabel];
    } else if ([_type isEqualToString:Button]) {
        self.button.center = self.view.center;
        [self.view addSubview:self.button];
        
    } else if ([_type isEqualToString:TextField]) {
        self.textField.center = self.view.center;
        [self.view addSubview:self.textField];
        
    } else if ([_type isEqualToString:Segmented_Control]) {
        self.segment.center = self.view.center;
        [self.view addSubview:self.segment];
        
    } else if ([_type isEqualToString:Slider]) {
        self.slider.center = self.view.center;
        [self.view addSubview:self.slider];
        
    } else if ([_type isEqualToString:Activity_Indicator_View]) {
//        self.label.center = self.view.center;
//        [self.view addSubview:self.label];
        
    } else if ([_type isEqualToString:Progress_View]) {
        self.progress.center = self.view.center;
        [self.view addSubview:self.progress];
        
    } else if ([_type isEqualToString:Page_Control]) {
        self.pageControl.center = self.view.center;
        [self.view addSubview:self.pageControl];
        
    } else if ([_type isEqualToString:Stepper]) {
        self.stepper.center = self.view.center;
        [self.view addSubview:self.stepper];
        
    } else if ([_type isEqualToString:Text_View]) {
        self.textView.center = self.view.center;
        [self.view addSubview:self.textView];
        
    } else if ([_type isEqualToString:Scroll_View]) {
        self.scrollView.center = self.view.center;
        [self.view addSubview:self.scrollView];
        
    } else if ([_type isEqualToString:Date_Picker]) {
        self.datePicker.center = self.view.center;
        [self.view addSubview:self.datePicker];
        
    } else if ([_type isEqualToString:Picker_View]) {
        self.pickerView.center = self.view.center;
        [self.view addSubview:self.pickerView];
        
    } else if ([_type isEqualToString:Table_View]) {
        [self.view addSubview:self.tableView];
        
    } else if ([_type isEqualToString:Collection_View]) {
        [self.view addSubview:self.collectionView];
        
    } else if ([_type isEqualToString:Tab_Bar]) {
        self.searchBar.center = self.view.center;
        [self.view addSubview:self.searchBar];
        
    }
}

- (void)createLabel{
    //1. 创建一个标签 设置大小, 位置
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 100, 200, 400);
    // UILabel是继承自UIView的, 所有的view都是矩形
    // CGRect 是一个结构体, 里面包含了一个点, 和一个大小  点==用来确定显示的位置，表示一个视图左上角的坐标        大小==确定范围（宽高）
    //2. 设置背景颜色
    // 默认是透明的
    label.backgroundColor = [UIColor redColor];
    //3. 设置显示文字
    NSString *text = @"hello world";
    
    label.text = text;
    //4. 设置显示内容的颜色
    label.textColor = [UIColor blueColor];
    //5. 对齐方式
    /**
     NSTextAlignmentLeft      = 0,  // 居左对齐
     NSTextAlignmentCenter    = 1,  // 居中对齐
     NSTextAlignmentRight           // 居右对齐
     */
    label.textAlignment = NSTextAlignmentCenter;
    //6.设置字体(UIFont)(label默认的字体大小是17)
    label.font = [UIFont systemFontOfSize:30];      // 系统字体
    label.font = [UIFont boldSystemFontOfSize:30];  // 系统字体 加粗
    label.font = [UIFont italicSystemFontOfSize:30];// 系统字体 斜体(不支持中文...)
    // 自定义字体
    // 可以获取当前设备支持的所有的字体
    NSArray *allfonts = [UIFont familyNames];
    NSLog(@"%@", allfonts);
    // 使用自定义字体(非系统的字体)(也不支持中文)
    label.font = [UIFont fontWithName:@"Futura" size:30];
    //    7. 字的阴影(shadow)
    label.shadowColor = [UIColor greenColor];   // 设置阴影的颜色
    label.shadowOffset = CGSizeMake(2, 2);      // 设置阴影的偏移量
    //    8. 换行
    // 最大显示的行数(默认是1)
    // Δ 这里需要去理解一下
    //  1. 当label的内容足够多, 而且, label足够高, 最大显示numberOfLines行
    //  2. 当label的内容足够多, 但是, label的高度不够高, 最大显示label能容纳多少行
    //  3. 当label的内容不够多, 能显示多少行, 显示多少行
    // 0 表示不限制最大行数
    label.numberOfLines = 0;
    //    9. 换行方式
    /**
     NSLineBreakByWordWrapping = 0, // 以单词换行
     NSLineBreakByCharWrapping,      // 以字母换行(iOS 7无效)
     NSLineBreakByClipping,          //
     NSLineBreakByTruncatingHead,    // 以单词换行, 省略最后一行开头
     NSLineBreakByTruncatingTail,    // 以单词换行, 省略最后一行结尾
     NSLineBreakByTruncatingMiddle   // 以单词换行, 省略最后一行中间
     */
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    //    10.设置是否能与用户进行交互
    label.userInteractionEnabled = YES;
    //  给label添加一个点击手势
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test)]];
    //    11.设置label中的文字是否可变，默认值是YES
    label.enabled = YES;
    //    12.设置字体大小适应label宽度     默认NO
    label.adjustsFontSizeToFitWidth = YES;
    //    13.如果adjustsFontSizeToFitWidth属性设置为YES，这个属性就来控制文本基线的行为
    label.baselineAdjustment = UIBaselineAdjustmentNone;
    /*
    typedef enum {
        UIBaselineAdjustmentAlignBaselines,
        UIBaselineAdjustmentAlignCenters,
        UIBaselineAdjustmentNone,
    } UIBaselineAdjustment;
    */
    //    14.设置高亮
    label.highlighted = YES;
    label.highlightedTextColor = [UIColor orangeColor];
    //     15.label根据文字改变高度
    [label sizeToFit];
    //    16. 根据文字的内容, 文字的大小, 换行.. 来获取需要占用的大小
    // 1. 文字需要显示的字体
    // 2. 最大显示的宽度
    CGSize size = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%@", NSStringFromCGSize(size));
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.center = self.view.center;
#pragma mark=====UILabel的另一种展现形式--富文本====
    
    //可以设置其中某段内容的显示样式
    // 1. string 表示要显示的内容
    // 2. attributes 表示这个字符串的属性
    // NSAttributeString只能整体设置属性
    // NSMutableAttributeString  可变, 可以单独给某一段设置属性
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
    /*  常用属性key:
     NSFontAttributeName : 设置字体的大小
     NSForegroundColorAttributeName : 设置字体的镂空颜色
     NSBackgroundColorAttributeName : 设置字体的背景颜色
     NSParagraphStyleAttributeName: 段落样式属性
     */
    // 1. 实例化一个段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    // 2. 设置行间距
    style.lineSpacing = 5;
    
    // 3. 给att添加一个属性
    
    //  给某一个范围的内容添加属性，range:就是 NSAttributeString和NSMutableAttributeString 区别所在
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor], NSFontAttributeName:[UIFont systemFontOfSize:20], NSBackgroundColorAttributeName: [UIColor greenColor], NSParagraphStyleAttributeName:style} range:NSMakeRange(0, text.length)];
    label.attributedText = att;
    self.label = label;
    [self.view addSubview:self.label];
}

- (void)test{
    NSLog(@" just a test");
}


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        
    }
    return _button;
}

- (UITextField *)textField {
    if (!_textField) {
        
    }
    return _textField;
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        
    }
    return _segment;
}

- (UISlider *)slider {
    if (!_slider) {
        
    }
    return _slider;
}

- (UISwitch *)switchON {
    if (!_switchON) {
        
    }
    return _switchON;
}

- (UIProgressView *)progress {
    if (!_progress) {
        
    }
    return _progress;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        
    }
    return _pageControl;
}

- (UIStepper *)stepper {
    if (!_stepper) {
        
    }
    return _stepper;
}

- (UITextView *)textView {
    if (!_textField) {
        
    }
    return _textView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
    }
    return _scrollView;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        
    }
    return _datePicker;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        
    }
    return _pickerView;
}

- (UISearchBar *)searchBar {
    if (_searchBar) {
        
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
