Class {
	#name : #PtyKeyboardLayout,
	#superclass : #Object,
	#instVars : [
		'name',
		'lowerChars',
		'upperChars',
		'lettersLayout',
		'symbolsLayout'
	],
	#category : #'Presenty-ScreenTools'
}

{ #category : #defaults }
PtyKeyboardLayout class >> english [
	^self new
		name: 'English';
		lowerChars: 'qwertyuiopasdfghjklzxcvbnm';
		upperChars: 'QWERTYUIOPASDFGHJKLZXCVBNM';
		lettersLayout: #('qwertyuiop' 'asdfghjkl' 'zxcvbnm')
]

{ #category : #'instance creation' }
PtyKeyboardLayout class >> named: aString [

	^self new name: aString 
]

{ #category : #defaults }
PtyKeyboardLayout class >> russion [

	^self new
		name: 'Russion';
		lowerChars: 'йцукенгшщзхъфывапролджэячсмитьбю';
		upperChars: 'ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ';
		lettersLayout: #('йцукенгшщзхъ' 'фывапролджэ' 'ячсмитьбю')
]

{ #category : #'initialize-release' }
PtyKeyboardLayout >> initialize [ 
	super initialize.
	lettersLayout := OrderedCollection new.
	symbolsLayout := OrderedCollection new
]

{ #category : #accessing }
PtyKeyboardLayout >> lettersLayout [
	^ lettersLayout
]

{ #category : #accessing }
PtyKeyboardLayout >> lettersLayout: anObject [
	lettersLayout := anObject
]

{ #category : #accessing }
PtyKeyboardLayout >> lowerChars [
	^ lowerChars
]

{ #category : #accessing }
PtyKeyboardLayout >> lowerChars: anObject [
	lowerChars := anObject
]

{ #category : #accessing }
PtyKeyboardLayout >> name [
	^ name
]

{ #category : #accessing }
PtyKeyboardLayout >> name: anObject [
	name := anObject
]

{ #category : #printing }
PtyKeyboardLayout >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: name asString;
		nextPut: $)
]

{ #category : #accessing }
PtyKeyboardLayout >> symbolsLayout [
	^ symbolsLayout
]

{ #category : #accessing }
PtyKeyboardLayout >> symbolsLayout: anObject [
	symbolsLayout := anObject
]

{ #category : #accessing }
PtyKeyboardLayout >> upperChars [
	^ upperChars
]

{ #category : #accessing }
PtyKeyboardLayout >> upperChars: anObject [
	upperChars := anObject
]

{ #category : #accessing }
PtyKeyboardLayout >> uppercaseLayout [
	^ lettersLayout collect: [:eachRow | 
		eachRow collect: [:eachChar | 
			upperChars at: (lowerChars indexOf: eachChar)
			]
		]
]
