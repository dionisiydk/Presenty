Class {
	#name : #PtyTouchWithPressEffectUserActionActivator,
	#superclass : #PtyUserActionActivator,
	#instVars : [
		'effectContainer'
	],
	#category : #'Presenty-UserActionActivators'
}

{ #category : #connecting }
PtyTouchWithPressEffectUserActionActivator >> hookupPresenter [ 

	presenter view on: #mouseDown send: #pressView to: self.
	presenter view on: #mouseUp send: #unpressViewBy: to: self
]

{ #category : #activation }
PtyTouchWithPressEffectUserActionActivator >> pressView [

	| flex |

	effectContainer := Morph new.
	effectContainer name: 'effectContainer'.
	effectContainer beTransparent.
	effectContainer extent: presenter view extent.
	effectContainer 
		changeTableLayout;
		vResizing: #rigid;
		hResizing: #rigid;
		listCentering: #center;
		wrapCentering: #center.

	presenter view replaceWith: effectContainer.

	effectContainer addMorph: presenter view.	
	flex := presenter view addFlexShell. 
	flex scale: 0.95
]

{ #category : #activation }
PtyTouchWithPressEffectUserActionActivator >> unpressViewBy: evt [
	| isClick |

	effectContainer ifNil: [^self].
	
	isClick := (presenter view containsPoint: evt cursorPoint).
	
	effectContainer submorphs first delete.
	effectContainer replaceWith: presenter view.
	effectContainer := nil.
		
	isClick ifTrue: [self executeAction]
	
	
]
