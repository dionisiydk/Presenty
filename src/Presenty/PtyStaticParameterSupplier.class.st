Class {
	#name : #PtyStaticParameterSupplier,
	#superclass : #PtyParameterizedActivator,
	#instVars : [
		'parameter'
	],
	#category : #'Presenty-UserActionActivators'
}

{ #category : #'instance creation' }
PtyStaticParameterSupplier class >> with: parameterObject [ 
	^self new 
		parameter: parameterObject 
]

{ #category : #activation }
PtyStaticParameterSupplier >> executeAction [ 
	
	action executeWith: parameter
]

{ #category : #accessing }
PtyStaticParameterSupplier >> parameter [
	self subclassResponsibility
]

{ #category : #accessing }
PtyStaticParameterSupplier >> parameter: anObject [
	self subclassResponsibility
]

{ #category : #printing }
PtyStaticParameterSupplier >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: parameter printString;
		nextPutAll: ' by '.
	
	basicActivator printOn: aStream.
		
	aStream nextPut: $)
]
