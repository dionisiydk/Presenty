Class {
	#name : #PtyValuePrinter,
	#superclass : #Object,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #converting }
PtyValuePrinter >> asMaskedWith: aString [ 

	^PtyCompositePrinter with: {self. PtyMaskedValuePrinter mask: aString}
]

{ #category : #converting }
PtyValuePrinter >> asSecrete [

	^PtyCompositePrinter with: {self. PtySecreteValuePrinter new}
]

{ #category : #accessing }
PtyValuePrinter >> editDecorator [ 
	self subclassResponsibility 
]

{ #category : #printing }
PtyValuePrinter >> printValue: anObject [
	self subclassResponsibility
]
