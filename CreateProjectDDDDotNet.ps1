# Nome da solução
$solutionName = "ProjectName"
$basePath = "$PSScriptRoot/$solutionName"

# Criar a estrutura base do projeto
Write-Output "Criando estrutura do projeto..."
New-Item -ItemType Directory -Path "$basePath"
New-Item -ItemType Directory -Path "$basePath/src"
New-Item -ItemType Directory -Path "$basePath/test"

# Criar os projetos principais
dotnet new sln -o $basePath -n $solutionName
dotnet new webapi --use-controllers -o "$basePath/src/$solutionName.API" -n "$solutionName.API"
dotnet new classlib -o "$basePath/src/$solutionName.Application" -n "$solutionName.Application"
dotnet new classlib -o "$basePath/src/$solutionName.Domain" -n "$solutionName.Domain"
dotnet new classlib -o "$basePath/src/$solutionName.Infrastructure" -n "$solutionName.Infrastructure"

# Adicionar os projetos a solucao
Write-Output "Adicionando projetos à solução..."
dotnet sln "$basePath/$solutionName.sln" add "$basePath/src/$solutionName.API/$solutionName.API.csproj"
dotnet sln "$basePath/$solutionName.sln" add "$basePath/src/$solutionName.Application/$solutionName.Application.csproj"
dotnet sln "$basePath/$solutionName.sln" add "$basePath/src/$solutionName.Domain/$solutionName.Domain.csproj"
dotnet sln "$basePath/$solutionName.sln" add "$basePath/src/$solutionName.Infrastructure/$solutionName.Infrastructure.csproj"

# Configurar as referencias entre projetos
Write-Output "Configurando referências entre projetos..."
dotnet add "$basePath/src/$solutionName.API/$solutionName.API.csproj" reference "$basePath/src/$solutionName.Application/$solutionName.Application.csproj"
dotnet add "$basePath/src/$solutionName.Application/$solutionName.Application.csproj" reference "$basePath/src/$solutionName.Domain/$solutionName.Domain.csproj"
dotnet add "$basePath/src/$solutionName.Infrastructure/$solutionName.Infrastructure.csproj" reference "$basePath/src/$solutionName.Domain/$solutionName.Domain.csproj"

# Criar subpastas e arquivos placeholders
Write-Output "Criando subpastas e arquivos..."
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.API/ViewModels"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.API/Middlewares"
Set-Content "$basePath/src/$solutionName.API/ViewModels/ExampleViewModel.cs" "public class ExampleViewModel { }"
Set-Content "$basePath/src/$solutionName.API/Middlewares/AuthenticationMiddleware.cs" "public class AuthenticationMiddleware { }"

New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Application/Service"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Application/DTOs"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Application/Interfaces"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Application/Validators"
Set-Content "$basePath/src/$solutionName.Application/DTOs/ExampleDTO.cs" "public class ExampleDTO { }"
Set-Content "$basePath/src/$solutionName.Application/Interfaces/IExampleService.cs" "public interface IExampleService { }"
Set-Content "$basePath/src/$solutionName.Application/Service/ExampleService.cs" "public class ExampleService : IExampleService { }"
Set-Content "$basePath/src/$solutionName.Application/Validators/ExampleValidator.cs" "public class ExampleValidator { }"

New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Domain/Entities"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Domain/ValueObjects"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Domain/Repositories"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Domain/Exceptions"
Set-Content "$basePath/src/$solutionName.Domain/Entities/Example.cs" "public class Example { }"
Set-Content "$basePath/src/$solutionName.Domain/ValueObjects/ExampleVO.cs" "public class ExampleVO { }"
Set-Content "$basePath/src/$solutionName.Domain/Repositories/IExampleRepository.cs" "public interface IExampleRepository { }"
Set-Content "$basePath/src/$solutionName.Domain/Exceptions/DomainException.cs" "public class DomainException : Exception { }"

New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Infrastructure/Logs"
New-Item -ItemType Directory -Path "$basePath/src/$solutionName.Infrastructure/Context"
Set-Content "$basePath/src/$solutionName.Infrastructure/Logs/Logger.cs" "public class Logger { }"
Set-Content "$basePath/src/$solutionName.Infrastructure/Context/AppDbContext.cs" "public class AppDbContext { }"

New-Item -ItemType Directory -Path "$basePath/test/$solutionName.Tests.API"
New-Item -ItemType Directory -Path "$basePath/test/$solutionName.Tests.Application"
New-Item -ItemType Directory -Path "$basePath/test/$solutionName.Tests.Domain"
New-Item -ItemType Directory -Path "$basePath/test/$solutionName.Tests.Infrastructure"
Set-Content "$basePath/test/$solutionName.Tests.API/ExampleControllerTests.cs" "public class ExampleControllerTests { }"
Set-Content "$basePath/test/$solutionName.Tests.Application/ExampleTests.cs" "public class ExampleTests { }"
Set-Content "$basePath/test/$solutionName.Tests.Domain/ExampleTests.cs" "public class ExampleTests { }"
Set-Content "$basePath/test/$solutionName.Tests.Infrastructure/ExampleRepositoryTests.cs" "public class ExampleRepositoryTests { }"

# Criar o arquivo .gitignore com os dados fornecidos
Write-Output "Criando arquivo .gitignore..."
$gitignoreContent = @"
*.swp
*.*~
project.lock.json
.DS_Store
*.pyc
nupkg/

# Visual Studio Code
.vscode/

# Rider
.idea/

# Visual Studio
.vs/

# Fleet
.fleet/

# Code Rush
.cr/

# User-specific files
*.suo
*.user
*.userosscache
*.sln.docstates

# Build results
[Dd]ebug/
[Dd]ebugPublic/
[Rr]elease/
[Rr]eleases/
x64/
x86/
build/
bld/
[Bb]in/
[Oo]bj/
[Oo]ut/
msbuild.log
msbuild.err
msbuild.wrn
"@

Set-Content -Path "$basePath/.gitignore" -Value $gitignoreContent

# Criar o arquivo README.md
Write-Output "Criando o arquivo README.md..."
$readmeContent = @"
# $solutionName

Este é o projeto $solutionName, estruturado com DDD (Domain-Driven Design).

## Estrutura do Projeto
- **API**: Contém os controladores e view models.
- **Application**: Contém os serviços, DTOs, interfaces e validadores.
- **Domain**: Contém as entidades, value objects, repositórios e exceções.
- **Infrastructure**: Contém as implementações de infraestrutura, como logs e contexto de banco de dados.

## Como Usar
1. Clone o repositório.
2. Restaure as dependências: `dotnet restore`.
3. Execute a solução: `dotnet run`.
"@

Set-Content -Path "$basePath/README.md" -Value $readmeContent

# Exibir mensagem final
Write-Output "Estrutura do projeto, .gitignore e README.md criados com sucesso!"
