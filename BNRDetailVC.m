#import "BNRDetailVC.h"
#import "BNRItem.h"

@interface BNRDetailVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_serial;
@property (weak, nonatomic) IBOutlet UITextField *tf_value;
@property (weak, nonatomic) IBOutlet UILabel *tf_date;
@property (weak, nonatomic) IBOutlet UIImageView *iv_show;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    BNRItem *item = self.item;
    self.tf_name.text=item.name;
    self.tf_serial.text=[NSString stringWithFormat:@"serial %d",  item.serial ];
    self.tf_value.text=item.value;
    static NSDateFormatter *dateFormatter =nil;
    if(!dateFormatter) {
        dateFormatter= [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.tf_date.text=[dateFormatter stringFromDate: item.dateValue];
    
    self.navigationItem.title=item.name;
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
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
      image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *imgUrl = [info valueForKey:UIImagePickerControllerReferenceURL] ;
    NSLog([NSString stringWithFormat:@"%@", imgUrl]);
   // self.tf_serial.text = imgUrl;
    image = [[UIImage alloc]initWithContentsOfFile:imgUrl];
   // self.iv_show.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
