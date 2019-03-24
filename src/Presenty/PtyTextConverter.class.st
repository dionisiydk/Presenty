Class {
	#name : #PtyTextConverter,
	#superclass : #Object,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #testing }
PtyTextConverter >> canConvertString: aString [

	self subclassResponsibility 
]

{ #category : #'text converting' }
PtyTextConverter >> readValueFrom: aString [
	self subclassResponsibility
]
