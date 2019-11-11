Class {
	#name : #PtyEditRequisiteWithToolTask,
	#superclass : #PtyEditRequisiteNewTask,
	#category : #'Presenty-ScreenTools'
}

{ #category : #'instance creation' }
PtyEditRequisiteWithToolTask class >> on: aFieldModel [
	^self new 
		model: aFieldModel 
]

{ #category : #execution }
PtyEditRequisiteWithToolTask >> body [ 

	| input |
	input := PtyFieldEditorPresenter on: model.	
	input 
		on: PtyInputComplete, PtyInputSubmitted, PtyInputLeftRequested, PtyValueChanged 
		send: #announce: to: self.
	"input on: PtyValueChanged send: #valueChanged to: self."
	workplace add: input toViewAreaOn: (name ifNil: ['editor']).	
	
	workplace add: input inputTool toViewAreaOn: 'editorTool'.
	
	user execute: [workplace showViewArea.
		input focusSilently]
	
]
