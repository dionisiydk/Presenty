Class {
	#name : #PtyComboBoxPresenter,
	#superclass : #PtyFieldEditorPresenter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #presentation }
PtyComboBoxPresenter >> activateItemsSelection [

	self focus.
]

{ #category : #presentation }
PtyComboBoxPresenter >> activateItemsSelectionAt: aPoint [

	guide restoreContext: self context.
	guide taskController uiActions reset.
	"guide showViewArea."
	guide executeTask: (PtyComboBoxInputTask field: self at: aPoint)
]

{ #category : #presentation }
PtyComboBoxPresenter >> comboListPosition [

	| panel global local bottomLeft |

	panel := view panelNamed: 'input'.
	bottomLeft := panel bottomLeft.
	global := view localPointToGlobal: bottomLeft.
	local := guide viewport view globalPointToLocal: global.	

	^local
]

{ #category : #presentation }
PtyComboBoxPresenter >> focus [ 
	| position |
	super focus.

	"position := self comboListPosition.
	guide runInUI: [self activateItemsSelectionAt:  position]"
]

{ #category : #presentation }
PtyComboBoxPresenter >> focused [

	super focused.
	

	


	
	
]

{ #category : #presentation }
PtyComboBoxPresenter >> showInputOn: aPanel [
	
	super showInputOn: aPanel.	
	
	self addUserAction: [self activateItemsSelection]
	
]

{ #category : #presentation }
PtyComboBoxPresenter >> takeFocusIfNeeded [
	"super takeFocusIfNeeded."
	
]
