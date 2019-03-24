Class {
	#name : #PtyEditRequisiteByToolTask,
	#superclass : #PtyEditRequisiteTask,
	#category : #'Presenty-ScreenTools'
}

{ #category : #'instance creation' }
PtyEditRequisiteByToolTask class >> on: aFieldModel [

	^self new 
		requisite: aFieldModel 
]

{ #category : #execution }
PtyEditRequisiteByToolTask >> createInput [ 
	
	super createInput.

	guide add: input inputTool toViewAreaOn: 'editorTool'.
	


]
