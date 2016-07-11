//
//  ViewController.m
//  NSVTextFieldDropDown
//
//  Created by srinivas on 7/11/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import "ViewController.h"
#import "NSVDropdownTextField.h"

@interface ViewController ()<dropDownDelegate,UITextFieldDelegate>{
    __weak IBOutlet NSVDropdownTextField *cityTF ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    cityTF.placeholder   = @"Select City" ;
    cityTF.delegate      =  self ;
    cityTF.dropdown = YES ;
    cityTF.dropdownDelegate = self ;
    //cityTF.displayElement = nil ;
    cityTF.dropdownElements = (NSMutableArray *)[NSArray arrayWithObjects:@"Hyderabad",@"Pune",@"Chennai",@"Amaravathi",@"Mumbai",nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark
#pragma --mark UITextFiled Delegate Methods
#pragma --mark

- (void)textFieldDidBeginEditing:(NSVDropdownTextField*)textField{
    [textField openDropDown];
    
}

- (void)textFieldDidEndEditing:(NSVDropdownTextField *)textField{
    [textField closeDropDown];
}

#pragma --mark
#pragma --mark UISearchBar Methods
#pragma --mark

- (BOOL)textField:(NSVDropdownTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField searchinDropDown:textField shouldChangeCharactersInRange:range replacementString:string];
}

#pragma --mark
#pragma --mark NSVTextFiled Delegate Methods
#pragma --mark


-(void)didSelectedElement:(id)selectItem andDisplayElemnt:(NSString *)disElement andTextFieldTag:(NSInteger)tag {
    
    NSLog(@"%s :%@",__func__,selectItem);
    
}

@end
