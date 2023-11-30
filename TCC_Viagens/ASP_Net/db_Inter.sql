-- criando o Banco de Dados --
create database db_Inter;

-- usando o banco de dados --
use db_Inter;

-- função para dropar o banco de dados --
drop database db_Inter;

-- criando as tabelas --
create table tbl_Cliente(
	idCliente int primary key auto_increment,
    nmCliente varchar (80) not null,
    noCPF varchar(14) not null unique,
    dsEmail varchar(50) not null unique
);
select * from tbl_Cliente;
/*drop table tbl_Cliente;*/

create table tbl_Login
(
	idLogin int primary key auto_increment,
    dsLogin varchar(30) unique,
    dsSenha char(8) not null,
    tipo int,
    idCliente int,
    constraint foreign key (idCliente) references tbl_Cliente(idCliente)
);
select * from tbl_Login;
drop table tbl_login;

create table tbl_TelCliente(
	idTelefone int primary key auto_increment,
    idCliente int,
    noTelefone char(11) not null,
    constraint foreign key (idCliente) references tbl_Cliente(idCliente)
);
drop table tbl_TelCliente;

create table tbl_Pacote(
	idPacote int primary key auto_increment,
    nmPacote enum("Entretenimento","Educação","Profissional") not null,
    dsPreco decimal(10, 2) not null,
    dsPacote varchar(300) not null,
    Imagem varchar(600) not null
);
/*drop table tbl_Pacote;*/
select * from tbl_Pacote;

create table tbl_Plano(
idPlano int Primary Key auto_increment,
nmPais varchar(150) not null,
nmCidade varchar(150) not null,
dsCidade varchar(999) not null,
dsClima varchar(100) not null,
dsEstadiaInicio varchar(10) not null,
dsEstadiaTermino varchar(10) not null,
dsEstadiaTotal varchar(150) not null,
dsMoeda varchar(150) not null,
dsIdiomaP varchar(80) not null,
dsIdiomaS varchar(80) not null,
idPacote int,
constraint foreign key (idPacote) references tbl_Pacote(idPacote) 
);
select idCom,dtComp,idCliente from tbl_Compra;
select * from tbl_Plano;
/*drop table tbl_Plano;*/

create table tbl_Compra(
	idCom int primary key auto_increment,
    dtComp datetime not null,
    idCliente int,
    constraint foreign key (idCliente) references tbl_Cliente(idCliente)
);
select * from tbl_Compra;

create table tbl_ItensCompra(
idItem int primary key auto_increment,
idCom int,
idPacote int,
constraint foreign key (idCom) references tbl_Compra(idCom),
constraint foreign key (idPacote) references tbl_Pacote(idPacote)
);
/*drop table tbl_ItensCompra;*/
select * from tbl_ItensCompra;	

create table tbl_Tipo_Pagamento(
	id_Tipo_Pagamento int primary key auto_increment,
    idCliente int references tbl_Cliente(idCliente),
    nm_Pagamento varchar(30)
);
/*drop table tbl_Tipo_Pagamento;*/


-- fim tabelas --

-- Stored Procedures -- 
-- Procedure para inserir Cliente -- 
drop procedure if exists sp_InsCli;
delimiter !!
create procedure sp_InsCli(
	in p_tipo int,
	in p_nm varchar(80),
    in p_noCPF varchar(14),
    in p_dsEmail varchar(50),
    in p_dsLogin varchar(30),
    in p_dsSenha char(8),    
    in p_noTelefone char(11)
)
begin
declare idCliente int;
	Start transaction;
    
		if(p_tipo = '1') then
        
		insert into tbl_Cliente (nmCliente, noCPF, dsEmail)
		values (p_nm, p_noCPF, p_dsEmail);
        
		set idCliente = last_insert_id();
        
		insert into tbl_login(dsLogin,dsSenha,tipo,idCliente) values (p_dsLogin,p_dsSenha,p_tipo, idCliente);
		insert into tbl_TelCliente(noTelefone, idCliente) values (p_noTelefone, idCliente);
        
        else
        select 'Função Inesperada' as Atenção;
        
        end if;
	Commit;
		Rollback;
end !!
delimiter ;
call sp_InsCli(1,'Ricardo','476.221.978-55','teste@teste.com','Ricardo','12345678','11997191092');

-- procedure para consultar Login -- 
drop procedure if exists sp_ConsLogin;
delimiter !!
create procedure sp_ConsLogin(
)
begin
	Start transaction;
        select * from tbl_Login
	Commit;
		Rollback;
end !!
delimiter ;

call sp_ConsLogin();

-- procedure para verifica Login -- 
drop procedure if exists sp_TestarLog;
delimiter !!
create procedure sp_TestarLog(
in p_dsLogin varchar(30),
in p_dsSenha char(8)
)
begin
	Start transaction;
    
        select * from tbl_Login where dsLogin = p_dsLogin and dsSenha = p_dsSenha;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_VerificaLog('admin', 'admin@23');


drop procedure if exists sp_VerificaLog;
delimiter !!
create procedure sp_VerificaLog(
in p_dsLogin varchar(30),
in p_dsSenha varchar(8)
)
begin
	Start transaction;
    
        select * from tbl_Login where dsLogin = p_dsLogin and dsSenha = p_dsSenha;
	Commit;
		Rollback;
end !!
delimiter ;

-- procedure para verifica CPF -- 
drop procedure if exists sp_VerificaCPF;
delimiter !!
create procedure sp_VerificaCPF(
in p_noCPF varchar(14)
)
begin
	Start transaction;
    
        select * from tbl_Cliente where noCPF = p_noCPF;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_VerificaCPF('476.221.978-55');

-- procedure para verifica Login email -- 
drop procedure if exists sp_VerificaEmail;
delimiter !!
create procedure sp_VerificaEmail(
in p_dsEmail varchar(50)
)
begin
	Start transaction;
    
        select * from tbl_Cliente where dsEmail = p_dsEmail;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_VerificaEmail('teste@teste.com');

-- Procedure para Inserir os Pacotes --
drop procedure if exists sp_InsPacote;
delimiter !!
create procedure sp_InsPacote(
	in p_nmPacote enum('Entretenimento','Educação','Profissional'),
    in p_dsPreco decimal(10, 2),
    in p_dsPacote varchar(300),
    in p_Imagem varchar(600)
)
begin
	Start transaction;
		
		insert into tbl_Pacote (nmPacote, dsPreco, dsPacote, Imagem)
		values (p_nmPacote, p_dsPreco, p_dsPacote, p_Imagem);
        
	Commit;
		Rollback;
end !!
delimiter ;

call sp_InsPacote('Entretenimento',1300.00,'O pacote perfeito para quem procura sair da rotina e explorar novos ares,
conhecendo lugares impressionantes e magnificos','irlanda1');

call sp_InsPacote('Profissional',1450.00,'O pacote perfeito para quem procura ingressar ou se aperfeiçoar na carreira profissional escolhids.','irlanda1');

call sp_InsPacote('Educação',1450.00,'O pacote perfeito para quem procura estudar nas melhores escola do Mundo.','irlanda1');

drop procedure if exists sp_InsPlanosPacotes;
delimiter !!
create procedure sp_InsPlanosPacotes(
	in p_nmPacote enum('Entretenimento','Educação','Profissional'),
    in p_dsPreco decimal(10, 2),
    in p_dsPacote varchar(300),
    in p_Imagem varchar(600),
	in p_nmPais varchar(150),
    in p_nmCidade varchar(150),
    in p_dsCidade varchar(999),
    in p_dsClima varchar(999),
    in p_dsEstadiaI varchar(10),
    in p_dsEstadiaT varchar(10),
    in p_dsEstadiaM varchar(150),
    in p_dsMoeda varchar(150),
    -- idioma principal --
    in p_dsIdiomaP varchar(80),
    -- idioma secundario --
    in p_dsIdiomaS varchar(80)
)
begin
	declare id_Pacote int;
	Start transaction;
		
    
		insert into tbl_Pacote (nmPacote, dsPreco, dsPacote,Imagem)
		values (p_nmPacote, p_dsPreco, p_dsPacote, p_Imagem);
		
        set id_Pacote = last_insert_id();

        
		insert into tbl_Plano(nmPais, nmCidade,dsCidade,dsClima,dsEstadiaInicio,dsEstadiaTermino,dsEstadiaTotal,dsMoeda,dsIdiomaP, dsIdiomaS, idPacote)
		values(p_nmPais, p_nmCidade,p_dsCidade, p_dsClima, p_dsEstadiaI, p_dsEstadiaT, p_dsEstadiaM, p_dsMoeda, p_dsIdiomaP, p_dsIdiomaS, id_Pacote);
	Commit;
		Rollback;
end !!
delimiter ;

-- Procedure para atualizar Pacote -- 
drop procedure if exists sp_UpPacoteId;
delimiter !!
create procedure sp_UpPacoteId(
	in p_nmPacote enum('Entretenimento','Educação','Profissional'),
    in p_dsPreco decimal(10,2),
    in p_dsPacote varchar(300),
    in p_Imagem varchar(600),
    in p_idPacote int
)
begin
	Start transaction;
		
		update tbl_Pacote set nmPacote = p_nmPacote, dsPreco = p_dsPreco, dsPacote = p_dsPacote, Imagem = p_Imagem
        where idPacote = p_idPacote; 
        
	Commit;
		Rollback;
end !!
delimiter ;

call sp_UpPacoteId('Profissional',1450.00,'O pacote perfeito para quem procura ingressar ou se aperfeiçoar na carreira profissional escolhida.','irlanda1', 2);

-- procedure para consultar Pacote -- 
drop procedure if exists sp_ConsPacote;
delimiter !!
create procedure sp_ConsPacote(
)
begin
	Start transaction;
    
        select idPacote, nmPacote, dsPreco, dsPacote, Imagem from tbl_Pacote
	Commit;
		Rollback;
end !!
delimiter ;

call sp_ConsPacote();

-- procedure para deletar Pacote -- 
drop procedure if exists sp_DeletePacote;
delimiter !!
create procedure sp_DeletePacote(
   in p_idPacote int
)
begin
	Start transaction;
    
        delete from tbl_Pacote where idPacote = p_idPacote;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_DeletePacote(3);

-- Procedure para Inserir os Planos --
drop procedure if exists sp_InsPlanos;
delimiter !!
create procedure sp_InsPlanos(
	in p_nmPais varchar(150),
    in p_nmCidade varchar(150),
    in p_dsCidade varchar(999),
    in p_dsClima varchar(100),
    in p_dsEstadiaI varchar(10),
    in p_dsEstadiaT varchar(10),
    in p_dsEstadiaM varchar(150),
    in p_dsMoeda varchar(150),
    -- idioma principal --
    in p_dsIdiomaP varchar(80),
    -- idioma secundario --
    in p_dsIdiomaS varchar(80),
    in p_idPacote int
)
begin
	Start transaction;
		insert into tbl_Plano(nmPais, nmCidade, dsCidade, dsClima, dsEstadiaInicio, dsEstadiaTermino, dsEstadiaTotal, dsMoeda, dsIdiomaP, dsIdiomaS, idPacote)
		values(p_nmPais, p_nmCidade, p_dsCidade, p_dsClima, p_dsEstadiaI, p_dsEstadiaT, p_dsEstadiaM, p_dsMoeda, p_dsIdiomaP, p_dsIdiomaS, p_idPacote);
	Commit;
		Rollback;
end !!
delimiter ;

call sp_InsPlanos('Irlanda', 'Dublin', 'Clássica nas listas de cidades para visitar dos viajantes, não tem como Dublin 
ficar de fora de qualquer aventura irlandesa. Você tem a cervejaria original da Guinness, o Trinity College, 
a Spire of Dublin, o castelo de Dublin, só para apontar alguns pontos de interesse, sem mencionar que a cidade 
inteira é repleta de história e caráter. Se você realmente quer sentir a vibe dessa animada cidade, a explore de noite; 
as ruas ganham vida logo que o sol se põe. Visite a área do Temple Bar (o Temple Bar é mais do que só um bar) para boas cervejas, 
uma galera internacional, e vá de bar em bar como jamais fez antes.', 'Clima oceânico', '21/07/2023', '21/08/2023', '01 Mês', 'Euro (€)', 'Irlandês', 'Inglês', 1);

select * from tbl_plano;

-- Procedure para atualizar Plano por id -- 
drop procedure if exists sp_UpPlanoId;
delimiter !!
create procedure sp_UpPlanoId(
	in p_idPlano int,
	in p_nmPais varchar(150),
    in p_nmCidade varchar(150),
    in p_dsCidade varchar(999),
    in p_dsClima varchar(100),
    in p_dsEstadiaI varchar(10),
    in p_dsEstadiaT varchar(10),
    in p_dsEstadiaM varchar(150),
    in p_dsMoeda varchar(150),
    in p_dsIdioma varchar(80)
)
begin
	Start transaction;
		update tbl_Plano set nmPais = p_nmPais, nmCidade = p_nmCidade, dsCidade = p_dsCidade, dsClima = p_dsClima, dsEstadiaInicio = p_EstadiaI,
        dsEstadiaTermino = p_dsEstadiaT, dsEstadiaTotal = p_dsEstadiaM, dsMoeda = p_dsMoeda, dsIdioma = p_dsIdioma
        where idPlano = p_idPlano; 
	Commit;
		Rollback;
end !!
delimiter ;

-- procedure para consultar Plano -- 
drop procedure if exists sp_ConsPlano;
delimiter !!
create procedure sp_ConsPlano(
)
begin
	Start transaction;
        select nmPais, nmCidade, dsCidade, dsClima, dsEstadiaInicio, dsEstadiaTermino, dsEstadiaTotal, 
        dsMoeda, dsIdiomaP, dsIdiomaS from tbl_Plano;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_ConsPlano();

-- procedure para editar Plano --
drop procedure if exists sp_EditPlano;
delimiter !!
create procedure sp_EditPlano(
in p_idPlano int
)
begin
	Start transaction;
    
        select nmPais, nmCidade, dsCidade, dsClima, dsEstadiaInicio, dsEstadiaTermino, dsEstadiaTotal, dsMoeda, dsIdiomaP, dsIdiomaS from tbl_Plano
        where idPlano = p_idPlano;
	Commit;
		Rollback;
end !!
delimiter ;

call sp_EditPlano();

-- procedure para deletar Plano -- 
drop procedure if exists sp_DeletePlano;
delimiter !!
create procedure sp_DeletePlano(
   in p_idPlano int
)
begin
	Start transaction;
    
        delete from tbl_Plano where idPlano = p_idPlano;
	Commit;
		Rollback;
end !!
delimiter ;

-- Procedure para filtrar os Planos
drop procedure if exists sp_FiltrarPlanos;
delimiter !!
create procedure sp_FiltrarPlanos(
in p_nmPais varchar(50),
in p_valor1 varchar(10),
in p_valor2 varchar(10),
in p_interesse varchar(50)
)
begin
	Start transaction;
    
			if(p_nmPais = 'erro' and p_valor1 = '000' and p_valor2 = '000' and p_interesse = 'erro')then
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote;
            
            elseif(p_nmPais = 'erro' and p_valor1 = '000' and p_valor2 = '000' and p_interesse != 'erro')then
			select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPacote = p_interesse;
            
            elseif(p_nmPais != 'erro' and p_valor1 = '000' and p_valor2 = '000' and p_interesse = 'erro')then
			select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPais like concat('%',p_nmPais,'%');
            
            elseif(p_nmPais = 'erro'and p_valor1 != '000' and p_valor2 != '000' and p_interesse = 'erro')then
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where dsPreco between p_valor1 and p_valor2;
            
            elseif(p_nmPais != 'erro'and p_valor1 != '000' and p_valor2 != '000' and p_interesse = 'erro')then
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPais like concat('%',p_nmPais,'%') and dsPreco between p_valor1 and p_valor2;
            
            elseif(p_nmPais != 'erro'and p_valor1 = '000' and p_valor2 = '000' and p_interesse != 'erro')then
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPais like concat('%',p_nmPais,'%') and nmPacote = p_interesse;
            
            elseif(p_nmPais = 'erro'and p_valor1 != '000' and p_valor2 != '000' and p_interesse != 'erro')then
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPacote = p_interesse and dsPreco between p_valor1 and p_valor2;
            
            else
            select * from tbl_Pacote inner join tbl_plano on tbl_Pacote.idPacote = tbl_plano.idPacote where nmPacote = p_interesse and dsPreco between p_valor1 and p_valor2
            and nmPais like concat('%',p_nmPais,'%');
            
            end if;
	Commit;
		Rollback;
end !!
delimiter ;
call sp_FiltrarPlanos('mando','0','10000','Profissional');

-- fim procedures --

insert into tbl_login (dsLogin, dsSenha, tipo) values('admin','admin@23',2);

select * from tbl_Plano;
select * from tbl_Pacote;
select * from tbl_login;

select * from tbl_Pacote
inner join tbl_Plano
on tbl_Pacote.idPacote = tbl_Plano.idPacote;