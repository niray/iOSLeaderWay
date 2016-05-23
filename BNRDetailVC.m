#import "BNRDetailVC.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_serial;
@property (weak, nonatomic) IBOutlet UITextField *tf_value;
@property (weak, nonatomic) IBOutlet UILabel *tf_date;
@property (weak, nonatomic) IBOutlet UIImageView *iv_show;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailVC

-(void)viewDidLoad{
    [super viewDidLoad];

    BNRItem *item = self.item;

    self.tf_name.text = item.name;
    self.tf_serial.text = [NSString stringWithFormat:@"serial %d", item.serial];
    self.tf_value.text = item.value;
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.tf_date.text = [dateFormatter stringFromDate:item.dateValue];
    self.tf_name.delegate = self;
    self.tf_serial.delegate = self;
    self.tf_value.delegate = self;
    self.navigationItem.title = item.name;

    NSString *itemKey = self.item.itemKey;

    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.iv_show.image = imageToDisplay;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)viewWillDisappear :(BOOL)animated{
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    item.name     = self.tf_name.text;
    item.serial   = self.tf_serial.text;
    item.value    = self.tf_value.text;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.iv_show.image = img;

    [[BNRImageStore sharedStore] setImage:img forKey:self.item.itemKey];
    
    NSString *imgUrl = [info valueForKey:UIImagePickerControllerReferenceURL] ;
    NSLog([NSString stringWithFormat:@"%@", imgUrl]);
    self.tf_serial.text = [NSString stringWithFormat:@"%@", imgUrl];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)removeItem:(BNRItem *)item {
    [[BNRImageStore sharedStore] deleteImageForKey:item.itemKey];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
