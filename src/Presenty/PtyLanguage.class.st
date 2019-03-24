Class {
	#name : #PtyLanguage,
	#superclass : #Object,
	#instVars : [
		'name',
		'icon',
		'keyboard'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyLanguage class >> named: aString [

	^self new name: aString 
]

{ #category : #accessing }
PtyLanguage >> icon [
	^ icon
]

{ #category : #accessing }
PtyLanguage >> icon: anObject [
	icon := anObject
]

{ #category : #'initialize-release' }
PtyLanguage >> initialize [ 

	super initialize.
	
	keyboard := PtyKeyboardLayout english
]

{ #category : #accessing }
PtyLanguage >> keyboard [
	^ keyboard
]

{ #category : #accessing }
PtyLanguage >> keyboard: anObject [
	keyboard := anObject
]

{ #category : #accessing }
PtyLanguage >> name [
	^name
]

{ #category : #accessing }
PtyLanguage >> name: anObject [
	name := anObject
]

{ #category : #printing }
PtyLanguage >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: name asString;
		nextPut: $)
]
