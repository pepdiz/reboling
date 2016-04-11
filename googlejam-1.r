rebol [
    Author: [ "Pep Diz" eukelade@gmail.com ]
    Title: "Counting Sheep"
    File:  %googlejam-1.r
    Version: 1.0
    Date: 10-04-2016
    Purpose: { This script solves the googlejam 2016 challenge number 1 Counting Sheep 
               Reads input from standard input and writes output to standard output }
    ]

init: [ #"0" false #"1" false #"2" false #"3" false #"4" false #"5" false #"6" false #"7" false #"8" false #"9" false ]

entrada: to-block read system/ports/input
 
for c 1 entrada/1 1 [
	p: none
	n: entrada/(c + 1)
	d: n
		
	dixitos: copy init
	until [
		foreach i to-string n [ dixitos/:i: true ]
		p: n
		n: d + n
		if p = n [p: "INSOMNIA" break]	
		all extract/index dixitos 2 2
	]

	print [join "Case #" [c ":"] p]
]
