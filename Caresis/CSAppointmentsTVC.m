//
//  CSAppointmentsTVC.m
//  Caresis
//
//  Created by James Kizer on 4/11/15.
//  Copyright (c) 2015 Caresis. All rights reserved.
//

#import "CSAppointmentsTVC.h"
#import "CSAdvocate.h"
#import "CSPatient.h"
#import "CSAppointment.h"
#import "CSAppointmentService.h"
#import "CSAppointmentViewController.h"

@interface CSAppointmentsTVC ()

@property (strong, nonatomic) NSArray *appointmentArray;
@property (weak, nonatomic) CSAppointment *selectedAppointment;

@end

@implementation CSAppointmentsTVC

-(NSArray *)appointmentArray
{
    if(!_appointmentArray) _appointmentArray = [[NSArray alloc]init];
    return _appointmentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //get list of appointments
    //reload table
    
    [self updateUI];
    
    
    
}

- (void)updateUI
{
    [[CSAppointmentService service] getAppointmentsOnSuccess:^(NSArray *appointments) {
        
        self.appointmentArray = appointments;
        [self.tableView reloadData];
        
    } failure:^{
        
        
        
    }];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.appointmentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AppointmentCell" forIndexPath:indexPath];
    
    
    CSAppointment *appointment = self.appointmentArray[indexPath.row];
    cell.textLabel.text = appointment.title;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:appointment.date];
    cell.tag = appointment.appointmentId;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedAppointment = [self.appointmentArray objectAtIndex:indexPath.row];
    
    
    
    
    
//    NSString *recipeId = [selectedRowDictionary objectForKey:@"id"];
//    
//    [[CLNetworkingController sharedController] getRecipe:recipeId onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        self.recipeToPass = [[CLRecipeModel alloc]initWithDictionary:(NSDictionary *)responseObject];
//        [self performSegueWithIdentifier:@"Show Recipe" sender:nil];
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
    
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([segue.identifier isEqualToString:@"AddAppointment"])
    {
        
        if ([[segue destinationViewController] isKindOfClass:[CSAppointmentViewController class]])
        {
            CSAppointmentViewController *apptVC = (CSAppointmentViewController *)[segue destinationViewController];
            apptVC.appointment = nil;
            
        }
        
    }
    else if([segue.identifier isEqualToString:@"EditAppointment"])
    {
        if ([[segue destinationViewController] isKindOfClass:[CSAppointmentViewController class]])
        {
            UITableViewCell *cell = (UITableViewCell *)sender;
            CSAppointmentViewController *apptVC = (CSAppointmentViewController *)[segue destinationViewController];
            apptVC.appointment = [self.appointmentArray objectAtIndex:cell.tag];
            
        }
        
    }
    
    
}

@end
