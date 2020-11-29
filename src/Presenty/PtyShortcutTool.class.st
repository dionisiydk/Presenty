Class {
	#name : #PtyShortcutTool,
	#superclass : #PtyTool,
	#instVars : [
		'keyCombination',
		'targetTask'
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

{ #category : #accessing }
PtyShortcutTool >> targetTask [
	^ targetTask
]

{ #category : #accessing }
PtyShortcutTool >> targetTask: anObject [
	targetTask := anObject
]
