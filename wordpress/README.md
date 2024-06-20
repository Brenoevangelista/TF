# Solides APP_NAME_HERE IaC

--------------------------------------------------------------------------------------------------------------------------------
Premissas:

 1. Reemplaze "APP_NAME_HERE" pelo nome da aplicação nas pastas, arquivos e strings de este projeto.
 2. Faça os ajustes necessarios no projeto, exemplo; variáveis de ambiente da task definition.
 3. Altere as regras de ingress do EC2 e behaviors do Cloudfront em "./templates".
 4. Adicione as variaveis aos arquivos *.tfvars.
 5. Copie as variáveis do arquivo "staging.tfvars" para o projeto no GitLab. (https://gitlab.solides.com.br)
 6. Preencha os valores para as variáveis copiadas dentro do GitLab.
 7. Realize as mudanças tanto no arquivo README como nos arquivos de arquitetura do projeto utilizando. (https://draw.io)
 8. Remova este bloco de instruções.

--------------------------------------------------------------------------------------------------------------------------------


Este projeto Terraform contem a infrastrutura do backend para o projeto APP_NAME_HERE (https://gitlab.solides.com.br/solides/plataforma/loja-solides/painel/painel-loja) a qual é criada utilizando o repositorio de modulos Terraform compartilhados para os seguintes serviços AWS:
    
    - CloudFront
    - EC2 Instance
    - EC2 Security Group

    Modulos proprietarios do projeto APP_NAME_HERE:

        - Templates = contem os arquivos para ajustar os behaviors do CloudFront e regras do Security Group.

    Proximos passos:

        - Adicionar registro e apontamento DNS ao dompinio do Cloudfront da aplicação na conta AWS Legada.

**APP_NAME_HERE Infrastructure blueprint:**
>
>![Solides - APP_NAME_HERE Architecture](./APP_NAME_HERE_iac.PNG)


## Requerimentos para execução local:
* terraform
* aws cli
* aws S3 bucket names

## Setup para execução local
1. Crei um perfil de acesso programatico na AWS.

2. Crie um perfil para o aws-cli executando o seguindo commando no seu terminal:
    ```aws configure --profile {AWS_CLI_PROFILE}```

3. Inicie o projeto localmente substituindo a variavel "profile":
init:
    ```terraform init -backend-config="bucket=sld-tf-app-states-stg" backend-config="profile={AWS_CLI_PROFILE}" -backend-config="region=us-east-1"```

4. Realize as mudanças necessarias e planifique o que será atualizado:
plan:
    ```AWS_PROFILE='{AWS_CLI_PROFILE}' terraform plan -var-file="{ENVIRONMENT}.tfvars"```

5. Uma vez entendidas as modificações que serão realizadas, execute o seguinte commando para aplicar as mesmas:
deploy:
    ```AWS_PROFILE='{AWS_CLI_PROFILE}' terraform apply -var-file="{ENVIRONMENT}.tfvars"```

----------------------------------------------------------------------------------