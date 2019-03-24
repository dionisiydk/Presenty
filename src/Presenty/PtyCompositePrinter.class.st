Class {
	#name : #PtyCompositePrinter,
	#superclass : #PtyValuePrinter,
	#instVars : [
		'printers'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyCompositePrinter class >> with: printersCollection [

	^self new 
		printers: printersCollection 
			
]

{ #category : #accessing }
PtyCompositePrinter >> editDecorator [ 
	^printers last editDecorator 
]

{ #category : #'initialize-release' }
PtyCompositePrinter >> initialize [ 
	super initialize.
	
	printers := OrderedCollection new
]

{ #category : #printing }
PtyCompositePrinter >> printValue: anObject [

	^printers inject: anObject into: [:printed :each | each printValue: printed]
]

{ #category : #accessing }
PtyCompositePrinter >> printers [
	^ printers
]

{ #category : #accessing }
PtyCompositePrinter >> printers: anObject [
	printers := anObject
]
