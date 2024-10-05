$params = @{
    DisplayName = 'Ne Pas Permettre Ping'
    Profile = 'Domain'
    Protocol = 'ICMPv4'
    Direction = 'Outbound'
    Action = 'Block'
}

New-NetFirewallRule @params