const { json } = require("express");
const express = require("express");
const pool = require("../config");
const Joi = require('joi')

const enrollSchema = Joi.object({
  course_password: Joi.number().required(),
})

const commentSchema = Joi.object({
  data: Joi.string().required().max(255),
  post_id: Joi.required()
})

const router = express.Router();

// Get Course
router.get('/course/:courseId', async function (req, res, next) {
  try {
    const [rows1, fields1] = await pool.query(
      'SELECT p.*, u.user_image FROM post p join user u\
            on p.user_id = u.user_id WHERE course_id=?', [req.params.courseId]
    )

    const [rows2, fields2] = await pool.query(
      'SELECT c.* , u.user_image FROM post p INNER JOIN comment c\
             ON p.post_id = c.post_id join user u\
              ON c.user_id = u.user_id WHERE p.course_id = ?', [req.params.courseId]
    )
    res.json({ course: rows1, comment: rows2 })
  } catch (error) {
    res.status(500).json(error)
  }
});

// Create new comment
router.post('/comment', async function (req, res, next) {
  let temp_userc = req.body.user
  delete req.body.user
  delete req.body.userInfo
  try {
    await commentSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err)
  }
  const conn = await pool.getConnection();
  await conn.beginTransaction();
  try {
    let results = await conn.query(
      "INSERT INTO comment(user_id, post_id, name, c_material, date) " +
      "VALUES(?, ?, ?, ?, CURRENT_TIMESTAMP);",
      [temp_userc.user_id, req.body.post_id, temp_userc.fname + " " + temp_userc.lname, req.body.data]
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


router.post('/enrollCourse', async function (req, res, next) {

  let temp_user = req.body.data.user
  delete req.body.data.user
  try {
    await enrollSchema.validateAsync(req.body.data, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err)

  }
  if (temp_user.type == "teacher") {
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    const [[courseId]] = await pool.query(
      'SELECT course_id from course where password_course = ?', [req.body.data.course_password]
    )

    const [[check]] = await pool.query(
      'SELECT * FROM course_teacher where course_id = ? AND user_id = ?', [courseId.course_id, temp_user.user_id]
    )



    if (!check) {
      try {
        let results = await conn.query(
          "INSERT INTO course_teacher(user_id, course_id) " +
          "VALUES(?, ?);",
          [temp_user.user_id, courseId.course_id]
        );

        await conn.commit();
        res.send("success!");
      } catch (err) {
        await conn.rollback();
        return res.status(400).json(err);
      } finally {
        conn.release();
      }
    }
    else
      res.send("ท่านมีคอร์สนี้อยู่แล้ว")
  }
  else {
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    const [[courseId]] = await pool.query(
      'SELECT course_id from course where password_course = ?', [req.body.data.course_password]
    )
    const [[check]] = await pool.query(
      'SELECT * FROM student_course where course_id = ? AND user_id = ?', [courseId.course_id, temp_user.user_id]
    )

    if (!check) {
      await conn.beginTransaction();
      try {
        let results = await conn.query(
          "INSERT INTO student_course(user_id, date, course_id) " +
          "VALUES(?, CURRENT_TIMESTAMP, ?);",
          [temp_user.user_id, courseId.course_id]
        );

        await conn.commit();
        res.send("success!");
      } catch (err) {
        await conn.rollback();
        return res.status(400).json(err);
      } finally {
        conn.release();
      }
    }
    else
      res.send("ท่านมีคอร์สนี้อยู่แล้ว");
  }



});


// Delete comment
// router.delete('/comments/:commentId', async function (req, res, next) {
//     try {
//         const [rows1, fields1] = await pool.query(
//             'DELETE FROM comments WHERE id=?', [req.params.commentId]
//         )
//         res.json("success")
//     } catch (error) {
//         res.status(500).json(error)
//     }
// });


exports.router = router