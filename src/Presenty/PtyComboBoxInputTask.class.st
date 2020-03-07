Class {
	#name : #PtyComboBoxInputTask,
	#superclass : #PtyEditSingleOptionTask,
	#instVars : [
		'field',
		'position'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #'instance creation' }
PtyComboBoxInputTask class >> field: aFieldModel [

	^self new 
		field: aFieldModel 
]

{ #category : #'instance creation' }
PtyComboBoxInputTask class >> field: aFieldModel at: aPoint [

	^self new 
		field: aFieldModel;
		position: aPoint 
]

{ #category : #execution }
PtyComboBoxInputTask >> body [ 

	| item active viewArea |
	worker restoreActiveArea.
	active := worker viewport activeViewArea.
	viewArea := worker viewArea.	
	
	worker doInPopUp: [
		item := user select: 'ListFieldItem' from: requisite type items.
	] at: presenter comboListPosition.

	worker viewport 
		viewArea: viewArea;
		activeViewArea: active.
		
	worker requestUserWith: [worker showViewArea.
			requisite value: item value
		] andContinueWith: true.

	worker taskNavigator forgetTask: self.
		
	user lookAt: [
		worker restoreContext: context.
		worker showViewArea].
	
	
]

{ #category : #accessing }
PtyComboBoxInputTask >> createPresenter [ 

	presenter := PtyComboBoxPresenter on: model
]

{ #category : #accessing }
PtyComboBoxInputTask >> field [
	^ field
]

{ #category : #accessing }
PtyComboBoxInputTask >> field: anObject [
	field := anObject
]

{ #category : #accessing }
PtyComboBoxInputTask >> position [
	^ position
]

{ #category : #accessing }
PtyComboBoxInputTask >> position: anObject [
	position := anObject
]
