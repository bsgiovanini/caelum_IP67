//
//  BSGListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios3109 on 29/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGListaContatosViewController.h"
#import "BSGFormularioContatoViewController.h"
#import "BSGContato.h"

@implementation BSGListaContatosViewController

@synthesize contatos = _contatos;

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contatos count];
}

- (UITableViewCell*) tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdent = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault)
                                      reuseIdentifier:cellIdent];
        
    }
    
    BSGContato * contato = [self.contatos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = contato.nome;
    
    return cell;
    
}

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"Numero de contatos na lista %d", [self.contatos count]);
    [self.tableView reloadData];
    
    
}

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
    
    form.contatos = self.contatos;
    
    UINavigationController * nav = [[UINavigationController alloc ] initWithRootViewController:form];
    
    
    
    //Esta forma será deprecada no ios 6
    [self presentModalViewController:nav animated:YES];
    //UIAlertView * alert = [[UIAlertView alloc] initWithTitle: @"Exibir Formulario" message:@"Isso e um UIAlertView" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
}

@end
