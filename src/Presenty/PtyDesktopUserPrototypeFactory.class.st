Class {
	#name : #PtyDesktopUserPrototypeFactory,
	#superclass : #PtyTaskPrototypeFactory,
	#category : #'Presenty-DesktopUser'
}

{ #category : #factory }
PtyDesktopUserPrototypeFactory >> preferredEditSingleOptionTask [ 
	^PtyComboBoxInputTask new
]

{ #category : #factory }
PtyDesktopUserPrototypeFactory >> preferredListTask [
	^PtyShowScrollableListTask new
]
