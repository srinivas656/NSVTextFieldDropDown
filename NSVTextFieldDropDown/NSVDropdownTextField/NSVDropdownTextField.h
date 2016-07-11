//
//  NSVDropdownTextField.h
//  NSVTextFieldDropDown
//
//  Created by srinivas on 7/11/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol dropDownDelegate <NSObject>

-(void)didSelectedElement:(id)selectItem andDisplayElemnt:(NSString *)disElement andTextFieldTag:(NSInteger)tag ;

@end

@interface NSVDropdownTextField : UITextField <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *dropdownView ;
@property (nonatomic)BOOL dropdown ;
@property (nonatomic,strong)NSMutableArray *dropdownElements ;
@property (nonatomic,strong)NSString *displayElement ;
@property (nonatomic,weak)id <dropDownDelegate>dropdownDelegate ;


-(void)openDropDown ;
-(void)closeDropDown ;
- (BOOL)searchinDropDown:(NSVDropdownTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  ;


@end
