const express = require('express');

const PORT = process.env.PORT || 8000

const app = express();

app.get('/',(req,res) => {
    res.send("<h3> Codemedia Api up and running</h3>")
})


app.listen(PORT,()=>console.log(`server is running on PORT ${PORT}`))