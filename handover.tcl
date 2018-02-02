# Define options
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model
set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 50 ;# max packet in ifq
set val(nn) 9 ;# number of mobilenodes
set val(rp) DSDV ;# routing protocol
set val(x) 1000 ;# X dimension of topography
set val(y) 1000 ;# Y dimension of topography 
set val(stop) 150 ;# time of simulation end

set ns [new Simulator]
set tracefd [open simple.tr w]
set namtrace [open simwrls.nam w] 

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)



# configure the nodes
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON

for {set i 0} {$i < $val(nn) } { incr i } {
set n($i) [$ns node] 
}

# Provide initial location of mobilenodes
$n(0) set X_ 50.0
$n(0) set Y_ 200.0
$n(0) set Z_ 0.0

$n(1) set X_ 100.0
$n(1) set Y_ 100.0
$n(1) set Z_ 0.0

$n(2) set X_ 500.0
$n(2) set Y_ 50.0
$n(2) set Z_ 0.0


$n(3) set X_ 500.0
$n(3) set Y_ 500.0
$n(3) set Z_ 0.0

$n(4) set X_ 600.0
$n(4) set Y_ 200.0
$n(4) set Z_ 0.0

$n(5) set X_ 600.0
$n(5) set Y_ 600.0
$n(5) set Z_ 0.0

$n(6) set X_ 800.0
$n(6) set Y_ 800.0
$n(6) set Z_ 0.0

$n(7) set X_ 990.0
$n(7) set Y_ 600.0
$n(7) set Z_ 0.0

$n(8) set X_ 900.0
$n(8) set Y_ 350.0
$n(8) set Z_ 0.0


# constants 


set rcdrate(1) 10
set lossrate(1) 0.1
set ql 2
set qd 4
set qj 3
set dthreshold 100
set jthreshold 50



# first QDS value



set w1 0.15
set w2 0.15
set w3 0.15
set w4 0.15
set w5 0.2
set w6 0.2
set wifival(1) 160
set wifival(2) 200
set wifival(3) 10
set wifival(4) 10
set wifival(5) 200
set wifival(6) 137
set qoeval(1) 72


#logarithmic value
#set a [expr {log exp($qoeval(1))}]
set a(1) 1.85

set tpg(1) [expr {100*$wifival(4)/$rcdrate(1)}]
set lossrate(1) [ expr {$wifival(5)/($rcdrate(1)*45)}]
set lg(1) [ expr { (100)/(1+($lossrate(1)/12)) }]
set dg(1) [ expr { (100)/(1+($wifival(1)/$dthreshold)) }]
set jg(1) [ expr { (100)/(1+($wifival(2)/$jthreshold)) }]
set vg(1) [ expr { $wifival(3) }]
set pg(1) [ expr { (100)/pow((2.71828),($wifival(6)*2)) }]
set qos(1) [ expr { $w5*$tpg(1) + $w1*$lg(1) + $w2*$dg(1) + $w3*$jg(1) + $w6*$vg(1) + $w4*$pg(1) }]
set b(1) [ expr { (0.775*$a(1))+11.268 }]
set qds(1) [ expr { $qos(1)+$b(1) }]
puts $qds(1)









# second QDS value

set w1 0.15
set w2 0.15
set w3 0.15
set w4 0.15
set w5 0.2
set w6 0.2

set wimaxval(1) 120
set wimaxval(2) 150
set wimaxval(3) 20
set wimaxval(4) 12
set wimaxval(5) 140
set wimaxval(6) 68
set qoeval(2) 54

#logarithmic value
#set a(2) [expr {log exp($qoeval(2))}]
set a(2) 1.7324

set tpg(2) [expr {100*$wimaxval(4)/$rcdrate(2)}]
set lossrate(2) [ expr {$wimaxval(5)/($rcdrate(2)*45)}]
set lg(2) [ expr { (100)/(1+($lossrate(2)/12)) }]
set dg(2) [ expr { (100)/(1+($wimaxval(1)/$dthreshold)) }]
set jg(2) [ expr { (100)/(1+($wimaxval(2)/$jthreshold)) }]
set vg(2) [ expr { $wimaxval(3) }]
set pg(2) [ expr { (100)/pow((2.71828),($wimaxval(6)*2)) }]
set qos(2) [ expr { $w5*$tpg(2) + $w1*$lg(2) + $w2*$dg(2) + $w3*$jg(2) + $w6*$vg(2) + $w4*$pg(2) }]
set b(2) [ expr { (0.775*$a(2))+11.268 }]
set qds(2) [ expr { $qos(2)+$b(2) }]
puts $qds(2)






# third QDS value(LTE)

set w1 0.15
set w2 0.15
set w3 0.15
set w4 0.15
set w5 0.2
set w6 0.2

set lteval(1) 100
set lteval(2) 100
set lteval(3) 60
set lteval(4) 18
set lteval(5) 110
set lteval(6) 52
set qoeval(3) 80

#logarithmic value
#set a(3) [expr {log exp($qoeval(2))}]
set a(3) 1.9031

set tpg(3) [expr {100*$lteval(4)/$rcdrate(3)}]
set lossrate(3) [ expr {$lteval(5)/($rcdrate(3)*45)}]
set lg(3) [ expr { (100)/(1+($lossrate(3)/12)) }]
set dg(3) [ expr { (100)/(1+($lteval(1)/$dthreshold)) }]
set jg(3) [ expr { (100)/(1+($lteval(2)/$jthreshold)) }]
set vg(3) [ expr { $lteval(3) }]
set pg(3) [ expr { (100)/pow((2.71828),($lteval(6)*2)) }]
set qos(3) [ expr { $w5*$tpg(3) + $w1*$lg(3) + $w2*$dg(3) + $w3*$jg(3) + $w6*$vg(3) + $w4*$pg(3) }]
set b(3) [ expr { (0.775*$a(3))+11.268 }]
set qds(3) [ expr { $qos(3)+$b(3) }]
puts $qds(3)



# fourth QDS value(wifi)

set w1 0.13
set w2 0.13
set w3 0.13
set w4 0.13
set w5 0.24
set w6 0.24

set wifival(1) 160
set wifival(2) 200
set wifival(3) 10
set wifival(4) 10
set wifival(5) 200
set wifival(6) 137
set qoeval(4) 99


#logarithmic value
#set a [expr {log exp($qoeval(4))}]
set a(4) 1.9956

set tpg(4) [expr {100*$wifival(4)/$rcdrate(1)}]
set lossrate(4) [ expr {$wifival(5)/($rcdrate(1)*45)}]
set lg(4) [ expr { (100)/(1+($lossrate(4)/12)) }]
set dg(4) [ expr { (100)/(1+($wifival(1)/$dthreshold)) }]
set jg(4) [ expr { (100)/(1+($wifival(2)/$jthreshold)) }]
set vg(4) [ expr { $wifival(3) }]
set pg(4) [ expr { (100)/pow((2.71828),($wifival(6)*2)) }]
set qos(4) [ expr { $w5*$tpg(4) + $w1*$lg(4) + $w2*$dg(4) + $w3*$jg(4) + $w6*$vg(4) + $w4*$pg(4) }]
set b(4) [ expr { (0.775*$a(4))+11.268 }]
set qds(4) [ expr { $qos(4)+$b(4) }]
puts $qds(4)









# fifth QDS value(wimax)

set w1 0.13
set w2 0.13
set w3 0.13
set w4 0.13
set w5 0.24
set w6 0.24


set wimaxval(1) 120
set wimaxval(2) 150
set wimaxval(3) 20
set wimaxval(4) 12
set wimaxval(5) 140
set wimaxval(6) 68

set qoeval(5) 84

#logarithmic value
#set a(5) [expr {log exp($qoeval(5))}]
set a(5) 1.9243

set tpg(5) [expr {100*$wimaxval(4)/$rcdrate(2)}]
set lossrate(5) [ expr {$wimaxval(5)/($rcdrate(2)*45)}]
set lg(5) [ expr { (100)/(1+($lossrate(5)/12)) }]
set dg(5) [ expr { (100)/(1+($wimaxval(1)/$dthreshold)) }]
set jg(5) [ expr { (100)/(1+($wimaxval(2)/$jthreshold)) }]
set vg(5) [ expr { $wimaxval(3) }]
set pg(5) [ expr { (100)/pow((2.71828),($wimaxval(6)*2)) }]
set qos(5) [ expr { $w5*$tpg(5) + $w1*$lg(5) + $w2*$dg(5) + $w3*$jg(5) + $w6*$vg(5) + $w4*$pg(5) }]
set b(5) [ expr { (0.775*$a(5))+41.268 }]
set qds(5) [ expr { $qos(5)+$b(5) }]
puts $qds(5)



# sixth QDS value(LTE)

set w1 0.13
set w2 0.13
set w3 0.13
set w4 0.13
set w5 0.24
set w6 0.24

set lteval(1) 100
set lteval(2) 100
set lteval(3) 60
set lteval(4) 18
set lteval(5) 110
set lteval(6) 52

set qoeval(6) 10

#logarithmic value
#set a(6) [expr {log exp($qoeval(6))}]
set a(6) 1.0000

set tpg(6) [expr {100*$lteval(4)/$rcdrate(3)}]
set lossrate(6) [ expr {$lteval(5)/($rcdrate(3)*45)}]
set lg(6) [ expr { (100)/(1+($lossrate(6)/12)) }]
set dg(6) [ expr { (100)/(1+($lteval(1)/$dthreshold)) }]
set jg(6) [ expr { (100)/(1+($lteval(2)/$jthreshold)) }]
set vg(6) [ expr { $lteval(3) }]
set pg(6) [ expr { (100)/pow((2.71828),($lteval(6)*2)) }]
set qos(6) [ expr { $w5*$tpg(6) + $w1*$lg(6) + $w2*$dg(6) + $w3*$jg(6) + $w6*$vg(6) + $w4*$pg(6) }]
set b(6) [ expr { (0.775*$a(6)+11.268 }]
set qds(6) [ expr { $qos(6)+$b(6) }]
puts $qds(6)



# selction of QDS for first handover

if { $qds(1) > $qds(2) && $qds(1) > $qds(3)} {
puts "qds1 is greater"
set c 2
}
if { $qds(2) > $qds(1) && $qds(2) > $qds(3)} {
puts "qds2 is greater"
set c 3
}
if { $qds(3) > $qds(2) && $qds(3) > $qds(1)} {
puts "qds3 is greater"
set c 4
}

# selction of QDS for second handover

if { $qds(4) > $qds(5) && $qds(4) > $qds(6)} {
puts "qds4 is greater"
set d 6
}
if { $qds(5) > $qds(4) && $qds(5) > $qds(6)} {
puts "qds5 is greater"
set d 7
}
if { $qds(6) > $qds(4) && $qds(6) > $qds(5)} {
puts "qds6 is greater"
set d 8
}



# setup a UDP connection between n(0) and n(1)
set udp1 [new Agent/UDP]
$ns attach-agent $n(1) $udp1
set null1 [new Agent/Null]
$ns attach-agent $n(0) $null1
$ns connect $udp1 $null1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.01
$cbr1 set random_ 1
$cbr1 set maxpkts_ 1000
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$ns at 40.0 "$cbr1 start"

# setup a UDP connection between n(0) and n(2)
set udp2 [new Agent/UDP]
$ns attach-agent $n(2) $udp2
set null2 [new Agent/Null]
$ns attach-agent $n(0) $null2
$ns connect $udp2 $null2


set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 1000
$cbr2 set interval_ 0.01
$cbr2 set random_ 1
$cbr2 set maxpkts_ 1000
$cbr2 attach-agent $udp2
$cbr2 set type_ CBR
$ns at 80.0 "$cbr2 start"

# setup a UDP connection between n(5) and n(3)
set udp3 [new Agent/UDP]
$ns attach-agent $n(5) $udp3
set null3 [new Agent/Null]
$ns attach-agent $n(3) $null3
$ns connect $udp3 $null3


set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 1000
$cbr3 set interval_ 0.01
$cbr3 set random_ 1
$cbr3 set maxpkts_ 1000
$cbr3 attach-agent $udp3
$cbr3 set type_ CBR
$ns at 80.0 "$cbr3 start"

# setup a UDP connection between n(5) and n(7)
set udp4 [new Agent/UDP]
$ns attach-agent $n($d) $udp4
set null4 [new Agent/Null]
$ns attach-agent $n(5) $null4
$ns connect $udp4 $null4


set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 1000
$cbr4 set interval_ 0.01
$cbr4 set random_ 1
$cbr4 set maxpkts_ 1000
$cbr4 attach-agent $udp4
$cbr4 set type_ CBR
$ns at 130.0 "$cbr4 start"





#color changes for frst
for {set i 2} { $i < 5 } { incr i } {
   
$ns at 50.0 "$n($i) delete-mark N2"
$ns at 50.0 "$n($i) add-mark N2 blue circle"

}
$ns at 60.0 "$n($c) delete-mark N2"
$ns at 61.0 "$n($c) add-mark N2 red circle"


#colour changes for second
for {set i 6} { $i < 9 } { incr i } {
   
$ns at 1000.0 "$n($i) delete-mark N2"
$ns at 100.0 "$n($i) add-mark N2 blue circle"

}
$ns at 145.0 "$n($d) delete-mark N2"
$ns at 145.0 "$n($d) add-mark N2 red circle"



#defining heads
$ns at 0.0 "$n(0) label MN"
$ns at 0.0 "$n(1) label Wifi"
$ns at 0.0 "$n(2) label Wifi"
$ns at 0.0 "$n(3) label Wimax"
$ns at 0.0 "$n(4) label LTE"
$ns at 0.0 "$n(5) label MN"
$ns at 0.0 "$n(6) label Wifi"
$ns at 0.0 "$n(7) label Wimax"
$ns at 0.0 "$n(8) label LTE"


$ns at 10.0 "$n(0) setdest 700.0 300.0 5.0" 
$ns at 80.0 "$n(5) setdest 900.0 600.0 5.0" 

#Color change while moving from one group to another FRST
$ns at 40.0 "$n(0) delete-mark N2"
$ns at 60.0 "$n(0) add-mark N2 pink circle"


#Color change while moving from one group to another SECODN
$ns at 100.0 "$n(5) delete-mark N2"
$ns at 120.0 "$n(5) add-mark N2 pink circle"





# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
# 50 defines the node size for nam
$ns initial_node_pos $n($i) 50
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
$ns at $val(stop) "$n($i) reset";
}

# ending nam and the simulation 
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 150.01 "puts \"end simulation\" ; $ns halt"
proc stop {} {
global ns tracefd namtrace
$ns flush-trace
close $tracefd
close $namtrace
exec nam simwrls.nam &
}

$ns run
