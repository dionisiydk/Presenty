Class {
	#name : #PtyUserRequest,
	#superclass : #Notification,
	#category : #'Presenty-Tasks'
}

{ #category : #exceptiondescription }
PtyUserRequest >> defaultAction [
	"I must be handled by Presenty framework.
	Otherwise it is a bug and therefor the UnhandledError is signaled"

	UnhandledError signalForException: self
]
