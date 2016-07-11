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
    

# Delegate Methods 

  
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

