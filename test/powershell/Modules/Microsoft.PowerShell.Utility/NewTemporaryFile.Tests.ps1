﻿# This is a Pester test suite to validate the New-TemporaryFile cmdlet in the Microsoft.PowerShell.Utility module.
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#

<#
    Purpose:
        Verify that New-TemporaryFile creates a temporary file.

    Action:
        Run New-TemporaryFile.

    Expected Result:
        A FileInfo object for the temporary file is returned.
#>

Describe "NewTemporaryFile" -Tags "CI" {

    It "creates a new temporary file" {
        $tempFile = New-TemporaryFile

        Test-Path $tempFile | Should be $true
        $tempFile | Should BeOfType System.IO.FileInfo

        if(Test-Path $tempFile)
        {
            Remove-Item $tempFile -ErrorAction SilentlyContinue -Force
        }
    }

    It "with WhatIf does not create a file" {
        New-TemporaryFile -WhatIf | Should Be $null
    }

    It "has an OutputType of System.IO.FileInfo" {
        (Get-Command New-TemporaryFile).OutputType | Should Be "System.IO.FileInfo"
    }
}
