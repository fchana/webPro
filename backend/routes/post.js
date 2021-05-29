const { json } = require("express");
const express = require("express");
const pool = require("../config");
const path = require("path");
const fs = require("fs");
const multer = require("multer");
const Joi = require('joi')

const postSchema = Joi.object({
  title: Joi.string().required().max(255),
  content: Joi.string().required().max(255),
  courseId: Joi.number().required(),
  fname: Joi.string().required().max(255),
  user_id: Joi.number().required(),
  type: Joi.required(),
})
const router = express.Router();

// SET STORAGE
const storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads");
  },
  filename: function (req, file, callback) {
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});
const upload = multer({ storage: storage });

router.post('/post', upload.array("image", 5), async function (req, res, next) {

  let temp_image = req.body.image
  delete req.body.image

  try {
    await postSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err)
  }
  if (temp_image != "nopic") {
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    const file = req.files[0];
    let path;
    path = file.path.substring(6)
    try {

      let results = await conn.query(
        "INSERT INTO post(user_id, name, type, topic, p_material, datetime, course_id, post_image)\
          VALUES(?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?);",
        [req.body.user_id, req.body.fname, req.body.type, req.body.title, req.body.content, req.body.courseId, path]
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
  else {
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {

      let results = await conn.query(
        "INSERT INTO post(user_id, name, type, topic, p_material, datetime, course_id, post_image)\
          VALUES(?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, null);",
        [req.body.user_id, req.body.fname, req.body.type, req.body.title, req.body.content, req.body.courseId]
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
});


exports.router = router