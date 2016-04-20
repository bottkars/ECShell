﻿#
# Module manifest for module 'ecshell'
#
# Generated by: Karsten Bott
#
# Generated on: 20.04.2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'ECShell.psm1'

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '2a95bee0-34e3-4b1e-bef4-e8a310495c05'

# Author of this module
Author = 'Karsten Bott'

# Company or vendor of this module
CompanyName = 'EMC²'

# Copyright statement for this module
Copyright = '2016'

# Description of the functionality provided by this module
Description = 'Powershell/Rest Module for EMC ECS Configuration and Management'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('.\utils\utils.psm1'
'.\errors\ecserrors.psm1',
'.\Configuration\ECSConfiguration.psm1'
'.\Provisioning\ECSvarray.psm1',
'.\Provisioning\ECSbucket.psm1',
'.\Provisioning\ECSnodes.psm1',
'.\Users\ECSObjectUser.psm1')

# Functions to export from this module
FunctionsToExport = '*ECS*'

# Cmdlets to export from this module
CmdletsToExport = '*ECS*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/bottkars/ECShell'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}