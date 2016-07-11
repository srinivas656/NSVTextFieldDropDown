# NSVTextFieldDropDown
TextFiled Dropdown with beautiful animation , Easly handle with multiple fields and search the content on dropdown

 **To Create the Dropdown Textfiled**
 
    cityTF.placeholder   = @"Select City" ;
    cityTF.delegate      =  self ;
    cityTF.dropdown = YES ;
    cityTF.dropdownDelegate = self ;
    // If display array is NSDictionary -> NSArray 
    //cityTF.displayElement = nil ;
    cityTF.dropdownElements = (NSMutableArray *)[NSArray arrayWithObjects:@"Hyderabad",@"Pune",@"Chennai",@"Amaravathi",@"Mumbai",nil];
    

 **Dropdown Methods**
 
-(void)openDropDown ;

-(void)closeDropDown ;


# Delegate Methods 

 **UITextFiled Delegate Methods**

- (void)textFieldDidBeginEditing:(NSVDropdownTextField*)textField{
    [textField openDropDown];
}

- (void)textFieldDidEndEditing:(NSVDropdownTextField *)textField{
    [textField closeDropDown];
}

 **Search Method**

- (BOOL)textField:(NSVDropdownTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField searchinDropDown:textField shouldChangeCharactersInRange:range replacementString:string];
}

**NSVTextFiled Delegate Methods**

-(void)didSelectedElement:(id)selectItem andDisplayElemnt:(NSString *)disElement andTextFieldTag:(NSInteger)tag {
    NSLog(@"%s :%@",__func__,selectItem);
}

