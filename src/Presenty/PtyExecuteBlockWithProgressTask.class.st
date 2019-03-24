Class {
	#name : #PtyExecuteBlockWithProgressTask,
	#superclass : #PtyBlockExecutionTask,
	#instVars : [
		'executionProcess',
		'warning'
	],
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #execution }
PtyExecuteBlockWithProgressTask >> body [

	guide addCancelAction.
	
	warning := PtyPresentersDecorator named: 'WaitingWarning'.
	
	user lookAt: warning and: [
		guide executeTask: (PtyReturnValueFromPresenterTask from: warning)].

	executionProcess := block newProcess.
	executionProcess
		name: self prototypeContextName;
		priority: Processor activeProcess priority - 1.
	
	[	
		executionProcess resume.
	
		[executionProcess isTerminated] whileFalse: [
			self showProgressInfo.
			1 seconds asDelay wait]
	] ensure: [executionProcess terminate]



]

{ #category : #accessing }
PtyExecuteBlockWithProgressTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]

{ #category : #execution }
PtyExecuteBlockWithProgressTask >> showProgressInfo [

	| stack progressContext info presenter |
	stack := executionProcess suspendedContext stack reversed.
	progressContext := stack detect: [:each | each receiver isKindOf: SequenceableCollection] ifNone: [nil].
	progressContext ifNil: [^self].
	
	info := progressContext progressInfo.
	presenter := info preferredPreviewPresenter.
	guide runInUI: [
		presenter context: guide context.
		guide preparePresenter: presenter.
		(guide context viewAreaActivator baseArea view panelNamed: 'body') 
			clear;
			add: presenter view.	
	]


]
