Class {
	#name : #PtyClipboardTextParameterSupplier,
	#superclass : #PtyParameterizedActivator,
	#category : #'Presenty-UserActionActivators'
}

{ #category : #execution }
PtyClipboardTextParameterSupplier >> executeAction [ 

	action executeWith: Clipboard clipboardText
]

{ #category : #printing }
PtyClipboardTextParameterSupplier >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
			
	basicActivator printOn: aStream.
		
	aStream nextPut: $)
]
