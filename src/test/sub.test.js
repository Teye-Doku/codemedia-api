const sub  = require('../helpers/sub');

describe('testing the sub function',()=>{
    it('should return 6 for 2,4',()=> {
        expect(sub(4,2)).toBe(2)
    })
})