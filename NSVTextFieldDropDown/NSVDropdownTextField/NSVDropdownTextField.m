//
//  NSVDropdownTextField.m
//  NSVTextFieldDropDown
//
//  Created by srinivas on 7/11/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import "NSVDropdownTextField.h"
@interface NSVDropdownTextField (){
    NSMutableArray *tableArray  ;
    NSInteger tfTag ;
    CGRect keyboardFrame ;
    UIView *keyBaseView  ;
}
@end

@implementation NSVDropdownTextField

- (void)awakeFromNib {
      super.delegate = self ;
    [self customizeTextField];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeTextField];
    }
    return self;
}

-(void)customizeTextField{
    
    self.superview.backgroundColor = [UIColor darkGrayColor];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.textColor = [UIColor darkGrayColor];
    self.layer.borderWidth = 0.1f ;
    self.layer.cornerRadius = 8.0f ;
    self.borderStyle = UITextBorderStyleNone ;
    // Padding
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 10, 40)];
    borderView.backgroundColor = [UIColor greenColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0,-10, 20, 40)];
    [paddingView addSubview:borderView];
    borderView = nil ;
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    paddingView = nil ;
}

-(void)openDropDown{
    if (_dropdown) {
        tableArray = [[NSMutableArray alloc] init];
        [tableArray addObjectsFromArray:_dropdownElements];
        _dropdownView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y+self.frame.size.height,self.frame.size.width,0)];
        _dropdownView.backgroundColor = [UIColor whiteColor];
        _dropdownView.layer.cornerRadius = 5.0f ;
        _dropdownView.layer.borderColor = [UIColor greenColor].CGColor;
        _dropdownView.layer.borderWidth = 2;
        _dropdownView.delegate   = self ;
        _dropdownView.dataSource = self ;
        
        [self.superview addSubview:_dropdownView];
        [self bringSubviewToFront:self.superview];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             UIViewController *base = (UIViewController *)_dropdownDelegate ;
                             float viewH = base.view.bounds.size.height-(_dropdownView.frame.origin.y+_dropdownView.frame.size.height+keyboardFrame.size.height);
                             _dropdownView.frame = CGRectMake(_dropdownView.frame.origin.x,_dropdownView.frame.origin.y ,_dropdownView.frame.size.width,viewH);
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

-(void)closeDropDown{
    [UIView animateWithDuration:0.5
                     animations:^{
                         float viewH = 0 ;
                         _dropdownView.frame = CGRectMake(_dropdownView.frame.origin.x,_dropdownView.frame.origin.y , _dropdownView.frame.size.width,viewH);
                     }
                     completion:^(BOOL finished){
                     }];
     [self resignFirstResponder];
}

#pragma mark - UITableview DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = [UIColor blueColor];
    }
    id data = [tableArray objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        cell.textLabel.text = data ;
    }else if ([data isKindOfClass:[NSDictionary class]]){
        cell.textLabel.text = [data valueForKey:_displayElement];
    }else{
        cell.textLabel.text = @"set display key";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell;
}

#pragma mark - UITableview Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeDropDown];
    [_dropdownDelegate didSelectedElement:[tableArray objectAtIndex:indexPath.row] andDisplayElemnt:_displayElement andTextFieldTag:tfTag];
}

- (BOOL)searchinDropDown:(NSVDropdownTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string    {
    //  remove all data that belongs to previous search
    
    tfTag = textField.tag ;
    NSString *str = nil ;
    if([string isEqualToString:@""]||string==nil){
        str = [NSString stringWithFormat:@"%@",[textField.text substringToIndex:[textField.text length]-1]];
    }else{
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    //BEGINSWITH ENDSWITH LIKE MATCHES CONTAINS
    [tableArray removeAllObjects];
    NSArray *fileter = nil ;
    if (_displayElement != nil) {
        
      // fileter = [_dropdownElements filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@[cd] %@",_displayElement,str]]];
        
    }else{
        fileter = [_dropdownElements filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",str]] ;
    }
    
    if (fileter.count) {
        [tableArray addObjectsFromArray:fileter];
    }else{
        [tableArray addObjectsFromArray:_dropdownElements];
    }
     [_dropdownView reloadData];
    
    return YES ;
}


@end
