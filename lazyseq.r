rebol [ 
Author: pep diz  
Library: [
	engine: r3
	platform: 'all 
	type: tool
	domain: [data]
	tested-under: windows
	support: none
	license: GPL
	see-also: none
	]
Title: "Lazy Sequence"
File: %lazyseq.r
Version: 1.1
Date: 10-04-2016
Purpose: { 
	functions to work with lazy sequences following the pattern [ first .. last ] with optional increment ( [ first .. last | inc ] )
	where first and last are integers or inf symbol and inc is a natural number (negative integers will be converted to absolute value)
	
	values allowed for first are integer! -inf inf none
	values allowed for last are integer! +inf inf none
	values allowed for inc are positive integers, zero is allowed but probably it is a nonsense to use it
	you can also use "to" rather than ".."
	
	ex:  [-inf to 783]  [none .. inf]  [inf .. 38] [ 1 to +inf] [-11 .. 74]
	
	alternatively you can give a generator for lazysequences rather than an increment value, you must ensure generator evals to a single integer value
	generators are blocks where symbol _ represents the current sequence value to operate on to get next value
	
	ex: [-inf .. 100 | [_ + 2] ] is equivalent to [-inf .. 100 | 2 ]
	    [ 2 .. 6000000 | [_ + _ ** 2 ]] expands to [16 1024 4194304] 
	
    lazysequences are sequences that deliver values on demand, you can get next value calling "next"  
    that is lazysequence are unevaluated sequence which get evaluated when asking for next value (lazy evaluation)
    allowing infinite sequence of numbers  (only integers allowed in this version)
    
}
todo: { bignums! }
]

context [

  nv: 1
  -inf: -9999999999999999999
  ts: none
  s: []
  
  srule: [set bl ['inf | '-inf | 'none | integer!] (bl: either integer? bl [bl] [-inf]) set op ['.. | 'to ] (op: none) set ul ['+inf | 'inf | 'none | integer! ] (ul: either integer? ul [ul] [none]) opt ['| set nv [integer! | block!] (if integer? nv [nv: abs nv] )] ]
  
  iseq: func [i [integer!] f [integer!] /local l] [l: reduce [i '.. f] if parse l srule [s: copy [] ts: l]]
  seq: func [ls [block!]] [ if parse ls srule [s: copy [] ts: ls]] 
{ el intervalo inicial de la secuencia es abierto (la secuencia no incluye bl): }  
  next: does [ if ts <> none [n: any reduce [op bl -inf] n: either integer? nv [nv + n] [to-integer do replace/all copy nv '_ n] if n <= any reduce [ul n] [append s n op: n ]] ]
{ si se quiere que el intervalo incluya el inicio (la secuencia empiece en bl), entonces definir next como: }
{ next: does [ if ts <> none [n: any reduce [op bl -inf] either n = bl [n] [n: either integer? nv [nv + n] [to-integer do replace/all copy nv '_ n] if n <= any reduce [ul n] [append s n op: n ]]] ] }
{ o bien cambiar seq e iseq para que añadan bl a s }

  sequence: does [ either ts = none [unset!] [s] ]
  first: does [ either ts = none [unset!] [bl] ]
  last: does [ either ts = none [unset!] [ul] ]
  nth: func [n [integer!]] [ either ts = none [unset!] [s/:n] ]
 
  set 'lazynext :self/next
  set 'lazyseq :self/seq
  set 'lazyseqi :self/iseq
  set 'lazysequence :self/sequence
  set 'lazyfirst :self/first
  set 'lazylast :self/last
  set 'lazypos :self/nth
]

