require('./helper')

describe 'Module', ->
  before ->
    NameMixin =
      length: -> @name.length
      first:  -> @name.charAt(0)

    class @TestClass extends Module
      @include(NameMixin)
      constructor: ->
        @name = 'TestClass'

  describe '#include', ->
    it 'mixin したメソッドを呼び出せること', ->
      test = new @TestClass()
      assert.equal(test.length(), 9)
      assert.equal(test.first(), 'T')

    it 'mixin したメソッドをオーバーライドできること', ->
      class SuperTest extends @TestClass
        first: -> 'nothing'
      test = new SuperTest()
      assert.equal(test.first(), 'nothing')

    it 'mixin したメソッドで super が実行できること', ->
      class SuperTest extends @TestClass
        first: -> super + '2'
      test = new SuperTest()
      assert.equal(test.first(), 'T2')
