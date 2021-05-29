const { json } = require("express");
const express = require("express");
const pool = require("../config");


const router = express.Router();

router.post('/showStd', async function (req, res, next) {
    const conn = await pool.getConnection();
    try {
      const [results] = await pool.query(
        "SELECT sc.enroll_id, s.std_id, u.fname, u.lname from user u join student s using (user_id)"+
        "join student_course sc using(user_id) where sc.course_id = ? ", [req.body.data])
      res.send(results);
    } catch (err) {
      return res.status(400).json(err);
    } finally {
      conn.release();
    }
});

exports.router = router