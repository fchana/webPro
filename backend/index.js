const express = require("express")

const app = express();
const cors = require('cors')
const { logger } = require('./middlewares')
app.use(logger)
app.use(cors())

// Statics
app.use(express.static('static'))
app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const indexRouter = require('./routes/index')
const courseRouter = require('./routes/course')
const userRouter = require('./routes/user')
const postRouter = require('./routes/post')
const stdManageRouter = require('./routes/stdManage')
const showStdRouter = require('./routes/showStd')
const removeStdRouter = require('./routes/removeStd')
const addCourseRouter = require('./routes/addCourse')
const registerRouter = require('./routes/register')

app.use(indexRouter.router)
app.use(courseRouter.router)
app.use(userRouter.router)
app.use(postRouter.router)
app.use(stdManageRouter.router)
app.use(showStdRouter.router)
app.use(removeStdRouter.router)
app.use(addCourseRouter.router)
app.use(registerRouter.router)


app.listen(3000, () => {
    console.log(`Example app listening at http://localhost:3000`)
})