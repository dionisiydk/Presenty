Class {
	#name : #PtyNumberTextConverter,
	#superclass : #PtyTextConverter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #testing }
PtyNumberTextConverter >> canConvertString: aString [
	| number givenWithPointsOnly |	
	aString ifEmpty: [^true].

	givenWithPointsOnly := aString copyReplaceAll: ',' with: '.'.
 
	(givenWithPointsOnly copyWithoutAll: '.') isAllDigits ifFalse: [^false].
	
 	(givenWithPointsOnly occurrencesOf: $.) > 1 ifTrue: [^false].
		
	^true
]

{ #category : #'text converting' }
PtyNumberTextConverter >> readValueFrom: aString [

	| givenWithPointsOnly |
	aString ifEmpty: [^nil].
	
	givenWithPointsOnly := aString copyReplaceAll: ',' with: '.'.
	givenWithPointsOnly first = $. ifTrue: [givenWithPointsOnly := '0', givenWithPointsOnly].
	
	^Number squeezeNumberOutOfString: givenWithPointsOnly
]
