//
//  BSGFormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGFormularioContatoViewController.h"
#import "BSGContato.h"
#import "BSGListaContatosViewController.h"
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>


@interface BSGFormularioContatoViewController ()

@end

@implementation BSGFormularioContatoViewController

@synthesize txtNome;

@synthesize txtTel;

@synthesize txtEmail;

@synthesize txtEnd;

@synthesize txtSite;

@synthesize contato = _contato;

@synthesize delegate = _delegate;

@synthesize photoButton = _photoButton;

@synthesize txtLat = _txtLat;

@synthesize txtLong = _txtLong;

@synthesize iv = _iv;

@synthesize contexto = _contexto;

- (id) initWithContato: (BSGContato *) _contato {
    
    self = [super init];
    
    if (self) {
        self.contato = _contato;
        
        UIBarButtonItem * confirmar = 
        [[UIBarButtonItem alloc ] initWithTitle:@"Confirma" style:UIBarButtonItemStylePlain target:self action: @selector(atualizaContato)];
        
        self.navigationItem.rightBarButtonItem = confirmar;
    }

    return self;
    

}

- (id)init {
    
    self = [super init];
    
    
    
    if(self) {
        
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem * cancelar = 
        [[UIBarButtonItem alloc ] initWithTitle:@"Cancela" style:UIBarButtonItemStylePlain target:self action: @selector(escondeFormulario)];
        
        UIBarButtonItem * cadastrar = 
        [[UIBarButtonItem alloc ] initWithTitle:@"Cadastra" style:UIBarButtonItemStylePlain target:self action: @selector(cadastraContato)];
        
        self.navigationItem.leftBarButtonItem = 
            cancelar;
        self.navigationItem.rightBarButtonItem = cadastrar;
    }
    
    
    
    
    return self;
    
    
}

- (void) escondeFormulario {
    [self dismissModalViewControllerAnimated:YES];
}

-(BSGContato*) pegaDadosDoFormulario {
    
    if (!self.contato) {
        self.contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.contexto];
    }
    
    self.contato.nome = self.txtNome.text;
    self.contato.telefone = self.txtTel.text;
    self.contato.email = self.txtEmail.text;
    self.contato.endereco = self.txtEnd.text;
    self.contato.site = self.txtSite.text;
    self.contato.latitude = [NSNumber numberWithFloat: [self.txtLat.text floatValue]];
    self.contato.longitude =[NSNumber numberWithFloat: [self.txtLong.text floatValue]];
    
    if (self.photoButton.imageView.image)
        self.contato.photo = self.photoButton.imageView.image;
    
    return self.contato;
}



- (void) cadastraContato {
    
    
    
    BSGContato * meucontato = [self pegaDadosDoFormulario];
    
    
    [self escondeFormulario];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:meucontato];
    }
    
    //diz para view para que qualquer que for o firstResponder abdicar de ser e o teclado desaparecer
    //[self.view endEditing:YES];
    
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: meucontato.nome message:@"Cadastro realizado com sucesso" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
    //Forma nova de navegar entre controllers
    //[self dismissModalViewControllerAnimated:YES];
    
       
}

- (void) atualizaContato {
    BSGContato * contato = [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate) {
        [self.delegate contatoAtualizado:contato];
    }
}

- (IBAction)proximoElemento:(UITextField*)sender {
    
    
    if (sender == self.txtNome) {
        [self.txtTel becomeFirstResponder];
    } else if (sender == self.txtTel) {
        [self.txtEmail becomeFirstResponder];
    } else if (sender == self.txtEmail) {
        [self.txtEnd becomeFirstResponder];
    } else if (sender == self.txtEnd) {
        [self.txtLat becomeFirstResponder];
    } else if (sender == self.txtLat) {
        [self.txtLong becomeFirstResponder];
    } else if (sender == self.txtLong) {
        [self.txtSite resignFirstResponder];
    }
    
}

-(IBAction)selecionaFoto:(id)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init ];
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
       
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto", nil];
        [sheet showInView: self.view];
        
        
        
    } else {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
    }
    
    [self presentModalViewController:picker animated:YES];

}


- (IBAction)localiza:(id)sender {
    
    [self.iv startAnimating];
    
    CLGeocoder *gc = [[CLGeocoder alloc]init];
    [gc geocodeAddressString:self.txtEnd.text completionHandler:^(NSArray *results, NSError *error) {
        
        if ((error == nil) && ([results count] > 0)) {
            CLPlacemark *r = [results objectAtIndex:0];
            CLLocationCoordinate2D c = r.location.coordinate;
            self.txtLat.text = [NSString stringWithFormat:@"%f", c.latitude];
            self.txtLong.text = [NSString stringWithFormat:@"%f", c.longitude];
        }
        
        [self.iv stopAnimating];
    }];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.contato) {
        
    
        self.txtNome.text = self.contato.nome;
        self.txtTel.text = self.contato.telefone;
        self.txtEnd.text = self.contato.endereco;
        self.txtSite.text = self.contato.site;
        self.txtEmail.text = self.contato.email;
        self.txtLat.text = [self.contato.latitude stringValue];
        self.txtLong.text = [self.contato.longitude stringValue];
        if(self.contato.photo)
            [self.photoButton setImage:self.contato.photo forState:UIControlStateNormal];
        
        
    }    
        
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.photoButton setImage:imagemSelecionada forState: UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
    
}

@end
