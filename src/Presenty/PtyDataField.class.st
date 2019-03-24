Class {
	#name : #PtyDataField,
	#superclass : #Object,
	#instVars : [
		'data',
		'desc'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyDataField class >> desc: aDataField [

	^self new desc: aDataField 
]

{ #category : #accessing }
PtyDataField >> becomeActive [

	data := PtyActiveDataModel on: data
]

{ #category : #presentation }
PtyDataField >> createEditorBy: aGuide [

	^desc createEditorFor: self by: aGuide
]

{ #category : #accessing }
PtyDataField >> data [
	^ data
]

{ #category : #accessing }
PtyDataField >> data: anObject [
	data := anObject
]

{ #category : #accessing }
PtyDataField >> desc [
	^ desc
]

{ #category : #accessing }
PtyDataField >> desc: anObject [
	desc := anObject
]

{ #category : #printing }
PtyDataField >> displayDecoratedValue [
	^ self printValue
]

{ #category : #accessing }
PtyDataField >> editDecorator [ 

	^desc editDecorator
]

{ #category : #'initialize-release' }
PtyDataField >> initialize [ 
	super initialize.
	
	data := PtyValueHolder new
]

{ #category : #testing }
PtyDataField >> isFull [
	^desc isValueFull: self value
]

{ #category : #testing }
PtyDataField >> isValid [
	^desc isValueValid: self value
]

{ #category : #accessing }
PtyDataField >> on: anAnnouncement send: aSymbol to: subscriber [

	data on: anAnnouncement send: aSymbol to: subscriber
]

{ #category : #presentation }
PtyDataField >> preferredPreviewPresenter [ 

	^PtyFieldPreviewPresenter on: self
]

{ #category : #printing }
PtyDataField >> printOn: aStream [

	super printOn: aStream.
	aStream 
		nextPutAll: ' ('; 
		nextPutAll: desc displayName;
		nextPutAll: ': '; 
		nextPutAll: data value asString; 
		nextPut: $)  
]

{ #category : #printing }
PtyDataField >> printValue [
	^desc printFieldValue: self value
]

{ #category : #accessing }
PtyDataField >> unsubscribe: anObject [ 
	data unsubscribe: anObject 
]

{ #category : #accessing }
PtyDataField >> value [
	^ data value ifNil: [
		desc defaultValue ifNotNilDo: [:v | data value: v. v]]
]

{ #category : #accessing }
PtyDataField >> value: anObject [

	data value: anObject 
]

{ #category : #presentation }
PtyDataField >> valuePreviewPresenter [
	^self value previewPresenterForFieldWith: desc
	
]

{ #category : #accessing }
PtyDataField >> valueSpec [

	^desc valueSpec
]
