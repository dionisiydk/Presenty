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
	workplace restoreActiveArea.
	active := workplace viewport activeViewArea.
	viewArea := workplace viewArea.	
	
	workplace doInPopUp: [
		item := user select: 'ListFieldItem' from: requisite type items.
	] at: presenter comboListPosition.

	workplace viewport 
		viewArea: viewArea;
		activeViewArea: active.
		
	workplace requestUserWith: [workplace showViewArea.
			requisite value: item value
		] andContinueWith: true.

	workplace taskNavigator forgetTask: self.
		
	user lookAt: [
		workplace restoreContext: context.
		workplace showViewArea].
	
	
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
