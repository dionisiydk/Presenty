Class {
	#name : #PtyUserTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyUserTest >> setUp [
	super setUp.

	workplace := Mock new.
	user := PtyUser of: workplace
]

{ #category : #tests }
PtyUserTest >> testTaskExecution [

	| result plannedTask |

	plannedTask := Mock new.
	(workplace stub planExecutionOf: #task) willReturn: plannedTask.
	
	result := user executeTask: #task.
	
	result should beReturnedFrom: [plannedTask requestExecution]
]
