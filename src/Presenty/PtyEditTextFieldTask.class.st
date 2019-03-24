Class {
	#name : #PtyEditTextFieldTask,
	#superclass : #PtyEditRequisiteNewTask,
	#instVars : [
		'field',
		'editor',
		'textConverter',
		'textSpec'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #'instance creation' }
PtyEditTextFieldTask class >> createPreferredInstanceBy: aPrototypesFactory [

	^self new
]

{ #category : #execution }
PtyEditTextFieldTask >> body [

	editor := PtyFieldEditorPresenter on: field.
	editor textConverter: textConverter.
	editor textSpec: textSpec.
	
	user lookAt: editor and: [editor focus]
]

{ #category : #accessing }
PtyEditTextFieldTask >> editor [
	^ editor
]

{ #category : #accessing }
PtyEditTextFieldTask >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
PtyEditTextFieldTask >> field [
	^ field
]

{ #category : #accessing }
PtyEditTextFieldTask >> field: anObject [
	field := anObject
]

{ #category : #'initialize-release' }
PtyEditTextFieldTask >> initialize [ 
	super initialize.
	
	textConverter := PtyNoneTextConverter new.
]

{ #category : #accessing }
PtyEditTextFieldTask >> readFromSample: anEditTask [

	super readFromSample: anEditTask.
	textConverter := anEditTask textConverter 
]

{ #category : #accessing }
PtyEditTextFieldTask >> textConverter [
	^ textConverter
]

{ #category : #accessing }
PtyEditTextFieldTask >> textConverter: anObject [
	textConverter := anObject
]

{ #category : #accessing }
PtyEditTextFieldTask >> textSpec [
	^ textSpec
]

{ #category : #accessing }
PtyEditTextFieldTask >> textSpec: spec [
	textSpec := spec
]
