//
//  CSAppointmentViewController.m
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import "CSAppointmentViewController.h"
#import "JVFloatLabeledTextView.h"
#import "JVFloatLabeledTextField.h"
#import "CSAppointmentService.h"

@interface CSAppointmentViewController () <UIPickerViewDataSource, UIPickerViewDelegate>



@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *titleTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *address1TextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *address2TextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cityTextField;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *stateTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *zipTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;



@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *dayBeforeReminder;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *dayOfTransportation;



@property (weak, nonatomic) IBOutlet UINavigationItem *appointNavItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *apptCompleteButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (nonatomic) BOOL newVersion;
@property (nonatomic) BOOL editMode;

@end

@implementation CSAppointmentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.patientPickerView.delegate = self;
//    self.patientPickerView.dataSource = self;
    
    self.descriptionTextView.placeholder = @"Description";
    
    self.dayBeforeReminder.placeholder = @"Day Before Reminder Message";
    self.dayOfTransportation.placeholder = @"Day Of Transportation Question";
    
    
    if(self.appointment)
    {
        self.newVersion = NO;
        self.appointNavItem.rightBarButtonItems = nil;
        self.apptCompleteButton.enabled = NO;
//        self.apptCompleteButton.target = self;
//        self.apptCompleteButton.action = @selector(toggleEditMode);
        
    }
    else
    {
        self.newVersion = YES;
        self.apptCompleteButton.target = self;
        self.apptCompleteButton.action = @selector(done);
        self.descriptionTextView.text = @"";
        self.dayBeforeReminder.text = @"";
        self.dayOfTransportation.text = @"";
    }
    
    self.editMode = NO;
    
    [self updateUI];
    
}

-(void)updateUI
{
    if(self.newVersion)
    {
        self.apptCompleteButton.title = @"Done";
        self.appointNavItem.title = @"New Appointment";
        self.containerView.userInteractionEnabled = YES;
    }
    else
    {
//        self.apptCompleteButton.title = @"Edit";
        self.appointNavItem.title = @"View Appointment";
        self.containerView.userInteractionEnabled = NO;
    }
}

//-(void)toggleEditMode
//{
//    self.editMode = !self.editMode;
//    [self updateUI];
//}
//
-(void)done
{
    CSAppointment *appointment = [[CSAppointment alloc] init];
    
    //title
    //description
    //date
    //address
    appointment.title = self.titleTextField.text;
    appointment.appointmentDescription = self.descriptionTextView.text;
    appointment.date = self.datePicker.date;
    
    [[CSAppointmentService service] addAppointment:appointment];
    [self.navigationController popViewControllerAnimated:YES];
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



#pragma mark - UIPickerViewDataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return @"Test Row";
}

@end
