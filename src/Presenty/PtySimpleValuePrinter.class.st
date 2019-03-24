Class {
	#name : #PtySimpleValuePrinter,
	#superclass : #PtyValuePrinter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtySimpleValuePrinter >> editDecorator [
	^PtyNoneEditDecorator new
]

{ #category : #printing }
PtySimpleValuePrinter >> printValue: anObject [
	anObject ifNil: [^''].
	
	^anObject asString
]
