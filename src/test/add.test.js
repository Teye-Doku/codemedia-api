const add  = require('../helpers/add');

describe('testing the add function',()=>{
    it('should return 6 for 2,4',()=> {
        expect(add(2,4)).toBe(6)
    })
})