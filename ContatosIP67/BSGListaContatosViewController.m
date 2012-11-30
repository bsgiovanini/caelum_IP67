//
//  BSGListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios3109 on 29/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGListaContatosViewController.h"
#import "BSGFormularioContatoViewController.h"

@implementation BSGListaContatosViewController

- (id) init {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)]; 
        
        self.navigationItem.rightBarButtonItem = button;
    }
    return self;
}

- (void) exibeFormulario {
    NSLog(@"Encaminhei");
    
    BSGFormularioContatoViewController * form = [[BSGFormularioContatoViewController alloc] init];
    
    //Esta forma será deprecada no ios 6
    [self presentModalViewController:form animated:YES];
    //UIAlertView * alert = [[UIAlertView alloc] initWithTitle: @"Exibir Formulario" message:@"Isso e um UIAlertView" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
}

@end
