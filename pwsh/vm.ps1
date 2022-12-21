
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force 

Connect-AzAccount -UseDeviceAuthentication

New-AzResourceGroup -Name rg-test -Location uksouth 

Get-AzResourceGroup | Format-Table 

$vm = Get-AzVM  -Name thor -ResourceGroupName  rg-test 

$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

New-AzVm -ResourceGroupName learn-c0fe2f66-b443-442f-a0ae-42c051fb8040 -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22 -PublicIpAddressName "testvm-01"

# $vm.HardwareProfile

# VmSize          VmSizeProperties
# ------          ----------------
# Standard_D2s_v3 


Update-AzVM -ResourceGroupName rg-test -VM $vm

Get-AzPublicIpAddress -ResourceGroupName rg-test -Name "testvm-01"

$vm = Get-AzVM  -Name thor -ResourceGroupName  rg-test 
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName


param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}