#import "BNRDetailVC.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property(weak, nonatomic) IBOutlet UITextField *tf_name;
@property(weak, nonatomic) IBOutlet UITextField *tf_serial;
@property(weak, nonatomic) IBOutlet UITextField *tf_value;
@property(weak, nonatomic) IBOutlet UILabel *tf_date;
@property(weak, nonatomic) IBOutlet UIImageView *iv_show;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(strong, nonatomic) UIPopoverController *imagePickerPopover;
@end

@implementation BNRDetailVC

- (void)viewDidLoad {
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


- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    BNRDetailVC *detailVC = [[BNRDetailVC alloc] initForNewItem:YES];

    detailVC.item = newItem;


    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    // navController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:navController animated:YES completion:nil];

}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"Wrong initalizer" reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}

- (instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;

            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (void)save:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
    //  [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender {
    [[BNRItemStore sharedStore] removeItem:self.item];
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (IBAction)takePicture:(id)sender {
    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    //替换为popover
    //如果为iPAD
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    item.name = self.tf_name.text;
    item.serial = self.tf_serial.text;
    item.value = self.tf_value.text;
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePickerPopover = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {

    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.iv_show.image = img;

    [[BNRImageStore sharedStore] setImage:img forKey:self.item.itemKey];

    NSString *imgUrl = [info valueForKey:UIImagePickerControllerReferenceURL];
    NSLog([NSString stringWithFormat:@"%@", imgUrl]);
    self.tf_serial.text = [NSString stringWithFormat:@"%@", imgUrl];

    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.iv_show.hidden = YES;
    } else {
        self.iv_show.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewsForOrientation:io];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self prepareViewsForOrientation:toInterfaceOrientation];
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
