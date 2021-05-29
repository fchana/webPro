const { json } = require("express");
const express = require("express");
const pool = require("../config");
const Joi = require('joi')

const addCourseSchema = Joi.object({
  course_name: Joi.string().required().max(255),
  course_semester: Joi.string().pattern(/[0-9]/).required(),
  course_password: Joi.string().pattern(/[0-9]/).required().max(10),
})

const router = express.Router();

// Create new comment
router.post('/addCourse', async function (req, res, next) {
  let temp_user = req.body.data.user
  delete req.body.data.user
  try {
    await addCourseSchema.validateAsync(req.body.data, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err)
  }
  const conn = await pool.getConnection();
  await conn.beginTransaction();
  try {
    let results = await conn.query(
      "INSERT INTO course(user_id, course_name, semester, password_course)\
        VALUES(?, ?, ?, ?);",
      [temp_user.user_id, req.body.data.course_name, req.body.data.course_semester, req.body.data.course_password]
    );


    let [[results2]] = await pool.query(
      "SELECT max(course_id) max_id from course",
    );

    let results3 = await conn.query(
      "INSERT INTO course_teacher(user_id, course_id)\
            VALUES(?, ?)",
      [temp_user.user_id, results2.max_id]
    );

    await conn.commit();
    res.send("success!");
  } catch (err) {
    await conn.rollback();
    return res.status(400).json(err);
  } finally {
    conn.release();
  }
});


exports.router = router