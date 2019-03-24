Class {
	#name : #PtyFieldDesc,
	#superclass : #Object,
	#instVars : [
		'displayName',
		'comment',
		'valuePrinter',
		'valueEditor',
		'defaultValue',
		'valueSpec'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtyFieldDesc >> comment [
	^ comment
]

{ #category : #accessing }
PtyFieldDesc >> comment: anObject [
	comment := anObject
]

{ #category : #presentation }
PtyFieldDesc >> createEditorFor: aDataField by: aGuide [

	| editTask |
	editTask := valueEditor copy.
	
	editTask guide: aGuide.	
	editTask field: aDataField.
	
	^editTask
]

{ #category : #accessing }
PtyFieldDesc >> createField [
	^PtyDataField desc: self
]

{ #category : #accessing }
PtyFieldDesc >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
PtyFieldDesc >> defaultValue: anObject [
	defaultValue := anObject
]

{ #category : #accessing }
PtyFieldDesc >> displayName [
	^ displayName
]

{ #category : #accessing }
PtyFieldDesc >> displayName: anObject [
	displayName := anObject
]

{ #category : #accessing }
PtyFieldDesc >> editDecorator [ 
	^valuePrinter editDecorator
]

{ #category : #'initialize-release' }
PtyFieldDesc >> initialize [ 
	super initialize.
	displayName := ''.
	comment := ''.
	valueSpec := Any.
	valuePrinter := PtySimpleValuePrinter new.
	valueEditor := PtyEditTextFieldTask new.
]

{ #category : #testing }
PtyFieldDesc >> isValueFull: anObject [ 
	^valueSpec isObjectFull: anObject 
]

{ #category : #testing }
PtyFieldDesc >> isValueValid: anObject [ 
	
	^(valueSpec validate: anObject) isSuccess
]

{ #category : #printing }
PtyFieldDesc >> printFieldValue: anObject [  
	
	^valuePrinter printValue: anObject 
]

{ #category : #accessing }
PtyFieldDesc >> valueEditor [
	^ valueEditor
]

{ #category : #accessing }
PtyFieldDesc >> valueEditor: anObject [
	valueEditor := anObject
]

{ #category : #accessing }
PtyFieldDesc >> valuePrinter [
	^ valuePrinter
]

{ #category : #accessing }
PtyFieldDesc >> valuePrinter: anObject [
	valuePrinter := anObject
]

{ #category : #accessing }
PtyFieldDesc >> valueSpec [
	^ valueSpec
]

{ #category : #accessing }
PtyFieldDesc >> valueSpec: anObject [
	valueSpec := anObject
]
