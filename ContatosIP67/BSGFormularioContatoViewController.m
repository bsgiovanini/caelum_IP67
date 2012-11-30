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

@interface BSGFormularioContatoViewController ()

@end

@implementation BSGFormularioContatoViewController

@synthesize txtNome;

@synthesize txtTel;

@synthesize txtEmail;

@synthesize txtEnd;

@synthesize txtSite;

@synthesize contatos = _contatos;

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
    BSGContato * contato = [[BSGContato alloc] init];
    contato.nome = self.txtNome.text;
    contato.telefone = self.txtTel.text;
    contato.email = self.txtEmail.text;
    contato.endereco = self.txtEnd.text;
    contato.site = self.txtSite.text;
    return contato;
}



- (void) cadastraContato {
    
    
    
    BSGContato * contato = [self pegaDadosDoFormulario];
    
    [self.contatos addObject:contato];
    
    [self escondeFormulario];
    
    //diz para view para que qualquer que for o firstResponder abdicar de ser e o teclado desaparecer
    //[self.view endEditing:YES];
    
    
    
    NSLog(@"Dados do contato: %@", self.contatos);
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: @"Cadastro realizado com sucesso" message:@"Isso e um UIAlertView" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
    //Forma nova de navegar entre controllers
    //[self dismissModalViewControllerAnimated:YES];
    
       
}

- (IBAction)proximoElemento:(UITextField*)sender {
    
    
    if (sender == self.txtNome) {
        [self.txtTel becomeFirstResponder];
    } else if (sender == self.txtTel) {
        [self.txtEmail becomeFirstResponder];
        
    } else if (sender == self.txtEmail) {
        [self.txtEnd becomeFirstResponder];
    } else if (sender == self.txtEnd) {
        [self.txtSite becomeFirstResponder];
    } else if (sender == self.txtSite) {
        [self.txtSite resignFirstResponder];
    }
    
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

@end
