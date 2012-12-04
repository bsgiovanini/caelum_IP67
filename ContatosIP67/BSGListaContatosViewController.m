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

@synthesize linhaDestaque = _linhaDestaque;

@synthesize contatoSelecionado = _contatoSelecionado;

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

- (void) viewDidAppear:(BOOL)animated {
    
    if (self.linhaDestaque >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestaque inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        self.linhaDestaque = -1;
        
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer * gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:gr];
    
}

- (void) exibeMaisAcoes: (UIGestureRecognizer*)gr {
    if(gr.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gr locationInView:self.tableView];
        NSIndexPath * ip = [self.tableView indexPathForRowAtPoint:ponto];
        BSGContato * contato = [self.contatos objectAtIndex: ip.row];
        
        self.contatoSelecionado = contato;
        
        UIActionSheet * as = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar",@"Enviar Email", @"Site", @"Mapa", nil];
        
        [as showInView:self.view];
    }
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
            
        default:
            break;
    }
}

- (void) ligar {
    NSLog(@"ligando...");
}

- (void) enviarEmail {
    NSLog(@"email...");
}

- (void) abrirSite {
    NSLog(@"site...");
}

- (void) mostrarMapa {
    NSLog(@"mapa...");
}


- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        
        NSArray * linhas = [NSArray arrayWithObject: indexPath];
        
        [tableView deleteRowsAtIndexPaths:linhas withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSGContato * contato = [self.contatos objectAtIndex:indexPath.row];
    BSGFormularioContatoViewController * form = [[BSGFormularioContatoViewController alloc] initWithContato:contato];
    
        
    [self.navigationController pushViewController:form animated:YES];

    
}



- (id) init {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)]; 
        
        self.navigationItem.rightBarButtonItem = button;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    self.linhaDestaque = -1;
    return self;
}

- (void) exibeFormulario {
    NSLog(@"Encaminhei");
    
    BSGFormularioContatoViewController * form = [[BSGFormularioContatoViewController alloc] init];
    
    form.delegate = self;
    
    UINavigationController * nav = [[UINavigationController alloc ] initWithRootViewController:form];
    
    
    
    //Esta forma será deprecada no ios 6
    [self presentModalViewController:nav animated:YES];
    //UIAlertView * alert = [[UIAlertView alloc] initWithTitle: @"Exibir Formulario" message:@"Isso e um UIAlertView" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
}

-(void) contatoAdicionado:(BSGContato*)contato {
    
    [self.contatos addObject:contato];
    NSLog(@"Contato Adicionado %d",[self.contatos indexOfObject:contato]);
    
    
    self.linhaDestaque = [self.contatos indexOfObject:contato];
    
    [self.tableView reloadData];
}

- (void) contatoAtualizado:(BSGContato*)contato {
    NSLog(@"Contato Atualizado %d",[self.contatos indexOfObject:contato]);
    self.linhaDestaque = [self.contatos indexOfObject:contato];
}

@end
