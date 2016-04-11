rebol [
	Author: [ "Pep Diz" eukelade@gmail.com ]
	Title: "Counting Sheep"
    File:  %googlejam-1.r
    Version: 1.0
    Date:       22-Mar-2007
    Purpose: { This script solves the googlejam 2016 challenge number 1 Counting Sheep 
			Reads input from file input.txt and writes to standard output }
    ]

init: [ #"0" false #"1" false #"2" false #"3" false #"4" false #"5" false #"6" false #"7" false #"8" false #"9" false ]

entrada: read/lines %input.txt

nc: to-integer first entrada

for c 1 nc 1 [
	r: none
	p: ""
	n: entrada/(c + 1)
	d: to-integer n
		
	dixitos: copy init
	until [
		foreach i n [ dixitos/:i: true ]
		p: copy n
		n: to-string (d + to-integer n)
		if p = n [r: "INSOMNIA" break]	
		all extract/index dixitos 2 2
	]

	if r = none [r: p]

	print join "Case #" [c ":" ] r
]
