Class {
	#name : #PtyTaskExample,
	#superclass : #PtyTask,
	#category : #'PresentyTests-Core'
}

{ #category : #controlling }
PtyTaskExample >> body [

	| answer item item2 |
	guide addBackAction.
		user warn: 'start'.

		answer := user confirm: 'Do you want wait?'.

		answer ifTrue: [
			user waitWhile: [
				(1 to: 100000) do: [:i | 200 milliSeconds asDelay wait].
			]
		].		
		item2 := 0.
		item := user select: 'NewNumber' from: (10 to: 100).		

		user warn: 'You choose: ', item asString.				

		guide addTask: [
			item2 := user select: 'NewNumber' from: (200 to: 300).		

			user warn: 'You choose from left: ', item2 asString.	
				
			user warn: 'sum: ', (item + item2) asString.				
		] named: 'SelectLeftNumber'.

		guide addTask: [
			item := user select: 'NewInteger' from: (10 to: 15).		

			user warn: 'You choose from right: ', item asString.					
		] named: 'SelectRightNumber'.				

		user warn: 'Please choose number'.
		
		item := user navigateThrough: (1 to: 100) of: Number.
		
		user warn: 'content of ', item asString.		
				
		answer ifTrue: [user warn: 'ok']
			ifFalse: [user warn: 'cancel'].
		
		user warn: 'end'.
		


	
		
]

{ #category : #accessing }
PtyTaskExample >> defaultActivationStrategy [ 
	^PtySeparatedTaskActivationStrategy new
]
