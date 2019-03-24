Class {
	#name : #PtyTaskConfigurationRequestTests,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'request'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskConfigurationRequestTests >> setUp [
	super setUp.
	
	task := Mock new.
	request := PtyTaskConfigurationRequest for: task.
]

{ #category : #tests }
PtyTaskConfigurationRequestTests >> testDefaultAction [

	request signal
]

{ #category : #tests }
PtyTaskConfigurationRequestTests >> testHandlesSameRequestsWithSameKindTask [

	| actual signalledRequest |
	[:signalledTask |
		signalledRequest := PtyTaskConfigurationRequest for: signalledTask.
		[actual := request handles: signalledRequest]
			should strictly satisfy: 
		[(signalledTask isKindOfTask: task) willReturn: #result].
		
		actual should be: #result.
	] runWithMocks 
]

{ #category : #tests }
PtyTaskConfigurationRequestTests >> testNotHandlesDifferentExceptionClasses [

	| actual |
	actual := request handles: Error new.
	
	actual should be: false
]
