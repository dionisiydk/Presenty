Class {
	#name : #PtyMaskedEditDecoratorTests,
	#superclass : #PtyEditDecoratorTestCase,
	#category : #'PresentyTests-UI'
}

{ #category : #accessing }
PtyMaskedEditDecoratorTests >> decoratorClass [
	^PtyMaskedEditDecorator
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testClearCharsAtMiddlePosition [
	
	decorator mask: '123***987**'.
	decorator decoratedValue: '123c*a987b*'.
	decorator clearCharsBack: 3 startingAt: 11.
	
	decorator decoratedValue should equal: '123c**987**'.
	decorator cursorPosition should equal: '123c*' size
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testClearCharsAtStartMaskedPosition [
	
	decorator mask: '123***987**'.
	decorator decoratedValue: '123c*a987b*'.
	decorator clearCharsBack: 3 startingAt: '123' size.
	
	decorator decoratedValue should equal: '123c*a987b*'.
	decorator cursorPosition should equal: '123' size.
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testClearCharsAtStartPosition [
	
	decorator mask: '123***987**'.
	decorator decoratedValue: '123c*a987b*'.
	decorator clearCharsBack: 3 startingAt: 1.
	
	decorator decoratedValue should equal: '123c*a987b*'.
	decorator cursorPosition should equal: 1.
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testDecorationBigValue [
	
	decorator mask: 'asd***zxc**'.
	decorator decorate: '123456789'.
	
	decorator decoratedValue should equal: 'asd123zxc45'.
	
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testDecorationValue [
	
	decorator mask: 'asd***zxc**'.
	decorator decorate: '1234'.
	
	decorator decoratedValue should equal: 'asd123zxc4*'.
	
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testDecorationValueShouldResetExistedChars [
	
	decorator mask: 'asd***zxc**'.
	decorator decoratedValue: 'asd***zxc67'.
	decorator decorate: '1234'.
	
	decorator decoratedValue should equal: 'asd123zxc4*'.

]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testGettingNativeValue [
	
	decorator mask: 'asd***zxc**bnm'.
	decorator decoratedValue: 'asd123zxc4*bnm'.
	
	decorator nativeValue should equal: '1234'
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testInsertingCharsAtLastPosition [
	
	decorator mask: '123***9876'.
	decorator insertChars: 'charstoomany' at: decorator mask size + 1.
	
	decorator decoratedValue should equal: '123***9876'.
	decorator cursorPosition should equal: decorator mask size + 1
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testInsertingCharsAtMiddlePosition [
	
	decorator mask: '123***987***'.
	decorator insertChars: 'chars' at: 2.
	
	decorator decoratedValue should equal: '123cha987rs*'.
	decorator cursorPosition should equal: '123cha987rs' size + 1
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testInsertingCharsWhenEmptyMask [
	
	decorator insertChars: 'chars' at: 1.
	
	decorator decoratedValue should equal: ''.
	decorator cursorPosition should equal: 1
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testInsertingToManyChars [
	
	decorator mask: '123***9876'.
	decorator insertChars: 'charstoomany' at: 2.
	
	decorator decoratedValue should equal: '123cha9876'.
	decorator cursorPosition should equal: decorator mask size + 1
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testSettingMaskShouldChangeDecoratedValue [
	| mask |
	mask := '123***9876'.
	decorator mask: mask.
	
	decorator decoratedValue should equal: mask.
	decorator decoratedValue should not be: mask.
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testShouldHasEmptyMaskByDefault [
	
	decorator mask should equal: ''
]

{ #category : #tests }
PtyMaskedEditDecoratorTests >> testShouldHasMaskCharByDefault [
	
	decorator maskChar should equal: $*
]
