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
	guide restoreActiveArea.
	active := guide viewport activeViewArea.
	viewArea := guide viewArea.	
	
	guide doInPopUp: [
		item := user select: 'ListFieldItem' from: requisite type items.
	] at: presenter comboListPosition.

	guide viewport 
		viewArea: viewArea;
		activeViewArea: active.
		
	guide requestUserWith: [guide showViewArea.
			requisite value: item value
		] andContinueWith: true.

	guide taskNavigator forgetTask: self.
		
	user lookAt: [
		guide restoreContext: context.
		guide showViewArea].
	
	
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
