Class {
	#name : #PtyListSelectionPresenter,
	#superclass : #PtyInputToolPresenter,
	#instVars : [
		'values'
	],
	#category : #'Presenty-ScreenTools'
}

{ #category : #presentation }
PtyListSelectionPresenter >> showViewItems [
		
	| button |
	
	values do: [ :each |

			button := PtyPresentersDecorator named: each withStyle: #listSelectionButton.
			button addUserAction: [self input setText: each].
				
			self showItem: button].		
]

{ #category : #accessing }
PtyListSelectionPresenter >> values [
	^ values
]

{ #category : #accessing }
PtyListSelectionPresenter >> values: anObject [
	values := anObject
]
