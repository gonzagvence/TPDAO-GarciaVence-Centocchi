# Trabajo Práctico Número 2: Desarrollo de una DAO
Enunciado desarrollado por Matías Rodriguez, Viviana Siless y Luz Alba Posse para el Trabajo Práctico Número 2 de la materia Introducción a Blockchain, dictada durante el primer semestre de 2024 (Escuela de Negocios, Universidad Torcuato Di Tella)

# Enunciado
Este repositorio contiene un template de implementación de una Organización Autónoma Descentralizada (DAO). Incluye el código base de los contratos inteligentes, scripts de deploy y pruebas.

## Comenzando

### Prerrequisitos

Está permitido utilizar una de las siguientes herramientas para el desarrollo y deployment:
- Remix (recomendado, dado lo que vimos en la materia)
- Truffle
- Hardhat
- Foundry (recomendado en caso de que hagan el punto adicional sobre unit testing)

### Instalación

Si deciden usar Truffle, Hardhat o Foundry, sigan estos pasos. De lo contrario, pueden usar Remix directamente.

Clonar el repositorio e instalar las dependencias (para Foundry, Truffle o Hardhat):

```bash
git clone https://github.com/luzalbaposse/desarrollo-de-una-dao
cd dao-project
npm install
```

## Ejecutar Pruebas
Para ejecutar las pruebas (para Truffle o Hardhat):

```bash
truffle test
# o
npx hardhat test
```

## Deploy
Para deployar los contratos a una red local (para Truffle o Hardhat):

```bash
truffle migrate --network development
# o
npx hardhat run scripts/deploy.js --network localhost
```

Para Remix, pueden deployar los contratos directamente copiando los archivos DAO.sol y Member.sol en el editor de Remix.

## Estructura del Proyecto
`contracts/:` Contiene los smart contracts.
`tests/:` Contiene los scripts de prueba para los contratos.
`scripts/:`Contiene los scripts de deploy y otros scripts auxiliares (para Hardhat).
`migrations/:` Contiene los scripts de migración (para Truffle).
