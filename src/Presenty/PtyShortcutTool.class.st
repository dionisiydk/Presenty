Class {
	#name : #PtyShortcutTool,
	#superclass : #PtyTool,
	#instVars : [
		'keyCombination'
	],
	#category : #'Presenty-Tools'
}

{ #category : #accessing }
PtyShortcutTool >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
PtyShortcutTool >> keyCombination: anObject [
	keyCombination := anObject
]
