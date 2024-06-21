-- Criar o database
CREATE DATABASE bd_Consultorio;
USE bd_Consultorio;

-- Criar tabela tb_Paciente
CREATE TABLE tb_Paciente (
    id_Paciente INT NOT NULL AUTO_INCREMENT,
    Nome_Paciente VARCHAR(100) NOT NULL, -- aceita números, letras e caracteres especiais
    Data_Nascimento_Paciente DATE NOT NULL, -- segue modelo americano (ano/mes/dia)
    Genero_Paciente ENUM('mulher', 'homem', 'nao-binario', 'mulher-trans', 'homem-trans'),
    Cpf_Paciente VARCHAR(14), -- campo aceita valores pre-determinados
    convenio VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_Paciente PRIMARY KEY (id_Paciente) -- aviso de primary key
);

-- Exibir estrutura da tabela
DESCRIBE tb_Paciente;

-- Inserir dados na tabela tb_Paciente
INSERT INTO tb_Paciente(Nome_Paciente, Data_Nascimento_Paciente, Genero_Paciente, Cpf_Paciente, convenio) VALUES
('Roberto Carlos', '1941/04/19', 'homem', '777.777.777-77', 'Amil'),
('Matue', '1993/10/11', 'homem', '333.333.333-33', 'Amil'),
('Pedro Paulo Soares Pereira', '1970/04/22', 'homem', '222.222.222-22', 'Amil'),
('Clarice Linspector', '1920/12/10', 'mulher', '111.111.111-11', 'Amil'),
('Roberto Justos', '1941/04/19', 'homem', '999.999.999-99', 'Amil');

-- Selecionar todos os dados da tabela tb_Paciente
SELECT * FROM tb_Paciente;

-- Criar tabela tb_Medico
CREATE TABLE tb_Medico (
    id_Medico INT NOT NULL AUTO_INCREMENT,
    Nome_Medico VARCHAR(100) NOT NULL,  -- aceita números, letras e caracteres especiais
    Data_Nascimento_Medico DATE NOT NULL, -- segue modelo americano (ano/mes/dia)
    Genero_Medico ENUM('mulher', 'homem', 'nao-binario', 'mulher-trans', 'homem-trans'),
    Crm_Medico VARCHAR(13), -- campo aceita valores pre-determinados
    Especialidade VARCHAR(30),
    Turno ENUM('Diurno','Noturno','Vespertino'),
    CONSTRAINT pk_id_Medico PRIMARY KEY (id_Medico)
);

-- Inserir dados na tabela tb_Medico
INSERT INTO tb_Medico(Nome_Medico, Data_Nascimento_Medico, Genero_Medico, Crm_Medico, Especialidade, Turno) VALUES
('Roberto', '1990/04/09', 'homem-trans', 'ABC123456890','Psiquiatra','Diurno'),
('Maria', '1963/10/01', 'mulher', 'CDE234456678','Clinico Geral','Noturno'),
('Paulo', '1976/04/23', 'homem', 'JKL098876654','Pediatra','Noturno'),
('Clara', '1980/02/12', 'mulher-trans', 'WER098123877','Otorrinolaringologista','Vespertino'),
('Akira', '1991/04/19', 'nao-binario', 'HGF123432567','Fisioterapeuta','Diurno');

-- Selecionar todos os dados da tabela tb_Medico
SELECT * FROM tb_Medico;

-- Criar tabela tb_Consulta
CREATE TABLE tb_Consulta (
    id_Consulta INT NOT NULL AUTO_INCREMENT,
    Data_Consulta DATE NOT NULL,
    Hora_Consulta TIME NOT NULL,
    fk_id_Paciente INT NOT NULL,
    fk_id_Medico INT NOT NULL,
    CONSTRAINT pk_id_Consulta PRIMARY KEY (id_Consulta),
    CONSTRAINT fk_id_Medico FOREIGN KEY (fk_id_Medico) REFERENCES tb_Medico (id_Medico),
    CONSTRAINT fk_id_Paciente FOREIGN KEY (fk_id_Paciente) REFERENCES tb_Paciente (id_Paciente)
);

-- Inserir dados na tabela tb_Consulta
INSERT INTO tb_Consulta (Data_Consulta, Hora_Consulta, fk_id_Medico, fk_id_Paciente) VALUES
('2024-05-24', '12:15:45', 1, 1),
('2024-05-24', '12:45:45', 2, 2),
('2024-05-24', '11:45:45', 3, 3),
('2024-05-24', '18:45:45', 4, 4),
('2024-05-24', '22:45:45', 5, 5);

-- Selecionar todos os dados da tabela tb_Consulta
SELECT * FROM tb_Consulta;

-- Exibir estrutura da tabela tb_Consulta
DESCRIBE tb_Consulta;

-- Criar tabela tb_Funcionario
CREATE TABLE tb_Funcionario (
    id_Funcionario INT NOT NULL AUTO_INCREMENT,
    Nome_Funcionario VARCHAR(100) NOT NULL,
    Data_Nascimento_Funcionario DATE NOT NULL,
    Genero_Funcionario ENUM('mulher', 'homem', 'nao-binario', 'mulher-trans', 'homem-trans'),
    Cargo VARCHAR(50),
    Salario DECIMAL(10, 2),
    CONSTRAINT pk_id_Funcionario PRIMARY KEY (id_Funcionario)
);

-- Inserir dados na tabela tb_Funcionario
INSERT INTO tb_Funcionario(Nome_Funcionario, Data_Nascimento_Funcionario, Genero_Funcionario, Cargo, Salario) VALUES
('João Silva', '1985/07/15', 'homem', 'Recepcionista', 3000.00),
('Ana Souza', '1990/03/20', 'mulher', 'Auxiliar Administrativo', 3500.00),
('Carlos Pereira', '1978/11/11', 'homem', 'Contador', 4500.00),
('Mariana Dias', '1983/08/05', 'mulher-trans', 'Gerente', 5500.00),
('Fernanda Lima', '1995/12/30', 'nao-binario', 'Enfermeiro', 4000.00);

-- Selecionar todos os dados da tabela tb_Funcionario
SELECT * FROM tb_Funcionario;

-- Atualizar o convênio de um paciente
UPDATE tb_Paciente SET convenio = 'Amil' WHERE id_Paciente = 1;

-- Selecionar Nome_Paciente e Genero_Paciente da tabela tb_Paciente
SELECT Nome_Paciente, Genero_Paciente FROM tb_Paciente;

-- Selecionar dados de tb_Consulta e tb_Paciente usando JOIN
SELECT * FROM tb_Consulta AS c
JOIN tb_Paciente AS p ON c.fk_id_Paciente = p.id_Paciente;

-- Selecionar dados específicos de tb_Consulta e tb_Paciente usando JOIN
SELECT c.Data_Consulta, p.Nome_Paciente FROM tb_Consulta AS c
JOIN tb_Paciente AS p ON c.fk_id_Paciente = p.id_Paciente;

-- Selecionar dados de tb_Consulta, tb_Paciente e tb_Medico usando JOIN
SELECT * FROM tb_Consulta AS c
JOIN tb_Paciente AS p ON c.fk_id_Paciente = p.id_Paciente
JOIN tb_Medico AS m ON c.fk_id_Medico = m.id_Medico;

-- Selecionar dados específicos de tb_Consulta, tb_Paciente e tb_Medico usando JOIN
SELECT c.Data_Consulta, p.Nome_Paciente, m.Nome_Medico FROM tb_Consulta AS c
JOIN tb_Paciente AS p ON c.fk_id_Paciente = p.id_Paciente
JOIN tb_Medico AS m ON c.fk_id_Medico = m.id_Medico
ORDER BY p.Nome_Paciente;

-- Deletar registros da tabela tb_Consulta onde id_Consulta é 2
DELETE FROM tb_Consulta WHERE id_Consulta = 2;

-- Deletar registros da tabela tb_Consulta onde fk_id_Medico é 1
DELETE FROM tb_Consulta WHERE fk_id_Medico = 1;
