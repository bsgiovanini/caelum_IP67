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

@synthesize contato;

@synthesize delegate = _delegate;

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
        self.contato = [[BSGContato alloc] init];
    }
    
    self.contato.nome = self.txtNome.text;
    self.contato.telefone = self.txtTel.text;
    self.contato.email = self.txtEmail.text;
    self.contato.endereco = self.txtEnd.text;
    self.contato.site = self.txtSite.text;
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
    
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: contato.nome message:@"Cadastro realizado com sucesso" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    if (self.contato) {
        
    
        self.txtNome.text = self.contato.nome;
        self.txtTel.text = self.contato.telefone;
        self.txtEnd.text = self.contato.endereco;
        self.txtSite.text = self.contato.site;
        self.txtEmail.text = self.contato.email;
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



@end
