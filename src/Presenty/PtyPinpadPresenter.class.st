Class {
	#name : #PtyPinpadPresenter,
	#superclass : #PtyInputToolPresenter,
	#instVars : [
		'decimalMode'
	],
	#category : #'Presenty-ScreenTools'
}

{ #category : #'instance creation' }
PtyPinpadPresenter class >> decimal [

	^self new decimalMode: true

	
]

{ #category : #'instance creation' }
PtyPinpadPresenter class >> digital [

	^self new decimalMode: false
]

{ #category : #accessing }
PtyPinpadPresenter >> decimalMode [
	^ decimalMode
]

{ #category : #accessing }
PtyPinpadPresenter >> decimalMode: anObject [
	decimalMode := anObject
]

{ #category : #'initialize-release' }
PtyPinpadPresenter >> initialize [ 
	super initialize.
	
	decimalMode := false
]

{ #category : #presentation }
PtyPinpadPresenter >> showViewItems [
	
	| button |
	
	'123456789' do: [ :each | 
		button := self buttonForChar: each withStyle: #pinpadButton.	
		self showItem: button].

	button := decimalMode
		ifTrue: [button := self buttonForChar: '.' withStyle: #pinpadButton.
			self showItem: button].

	button := self buttonForChar: '0' withStyle: #pinpadButton.
	self showItem: button
]
