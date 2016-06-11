require('./helper')

describe 'Array2D', ->
  beforeEach ->
    @table = new Array2D([
      [1,2,3,4,5]
      [5,1,2,3,4]
      [4,5,1,2,3]
    ])

  describe '#toString', ->
    it '２次元配列の中身を表現する文字列を返すこと', ->
      assert.equal(@table.toString(), "1,2,3,4,5\n5,1,2,3,4\n4,5,1,2,3")

  describe '#get', ->
    it 'int で指定した座標の値が取れること', ->
      assert.equal(@table.get(0,0), 1)
      assert.equal(@table.get(1,1), 1)
      assert.equal(@table.get(1,0), 2)
      assert.equal(@table.get(2,0), 3)
      assert.equal(@table.get(0,1), 5)
      assert.equal(@table.get(0,2), 4)

    it 'Point で指定した座標の値が取れること', ->
      assert.equal(@table.get(new Point(0,2)), 4)

    it '領域外アクセスはエラーとなること', ->
      access = => @table.get(10,0)
      assert.throws(access, /out of bounds/)

  describe '#set', ->
    it '指定した座標の値が変わること', ->
      @table.set(1, 2, 100)
      @table.each (value, x, y)->
        if x == 1 && y == 2
          assert.equal(value, 100)
        else
          assert(value < 10)

  describe '#delete', ->
    it 'int で指定した座標の値が消えること', ->
      @table.delete(1, 2)
      assert.equal(@table.get(1,2), null)

    it 'Point で指定した座標の値が消えること', ->
      @table.delete(new Point(1, 2))
      assert.equal(@table.get(1,2), null)

  describe '#rotate', ->
    it '時計回りに90度回転した２次元配列が得られること', ->
      rotated = @table.rotate()
      result = new Array2D([
        [4,5,1]
        [5,1,2]
        [1,2,3]
        [2,3,4]
        [3,4,5]
      ])
      assert.equal(rotated.toString(), result.toString())

  describe '#eachRound', ->
    before ->
      @table = new Array2D([
        [0,0,0,0,0]
        [0,1,2,3,0]
        [0,0,0,0,0]
      ])

    it '周に対して操作が行われること', ->
      @table.eachRound (val, x, y) =>
        assert.equal(@table.get(x, y), 0)
