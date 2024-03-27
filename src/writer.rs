use std::collections::{HashMap, VecDeque};
use std::fs::{read_to_string, File};
use std::io::prelude::*;
use std::path::PathBuf;

use anyhow::Result;
use tera::{Context, Tera};
/**
 * File writer.
 */

pub struct Writer {
    context: Context,
    targets: HashMap<String, WriteTarget>,
}

pub struct WriteTarget {
    path: PathBuf,
    rules: Vec<WriteRule>,
}

pub struct WriteRule {
    /**
     * Search target.
     *
     * Value is rendered by Tera.
     */
    pub search: String,
    /**
     * Replacement content.
     *
     * Value is rendered by Tera.
     */
    pub replace: String,
}

impl Writer {
    pub fn new(ctx: &Context) -> Self {
        return Self {
            context: ctx.clone(),
            targets: HashMap::new(),
        };
    }

    pub fn add_target(&mut self, path: &PathBuf, search: &String, replace: &String) {
        let path_key = path.display().to_string();
        if !self.targets.contains_key(&path_key) {
            self.targets
                .insert(path_key.clone(), WriteTarget::new(&path));
        }
        let target = self.targets.get_mut(&path_key).unwrap();
        target.add_rule(
            Tera::one_off(&search, &self.context, true)
                .unwrap()
                .to_string(),
            Tera::one_off(&replace, &self.context, true)
                .unwrap()
                .to_string(),
        );
    }

    pub fn update_all(&self) -> Result<()> {
        for t in self.targets.values() {
            t.update().unwrap();
        }
        Ok(())
    }
}

impl WriteTarget {
    pub fn new(path: &PathBuf) -> Self {
        return Self {
            path: path.clone(),
            rules: Vec::new(),
        };
    }

    pub fn update(&self) -> Result<()> {
        let mut text = read_to_string(&self.path).unwrap();
        for rule in &self.rules {
            text = rule.update(text);
        }
        let mut out = File::create(&self.path)?;
        let _ = out.write(text.as_bytes());
        Ok(())
    }

    pub fn add_rule(&mut self, search: String, replace: String) {
        self.rules.push(WriteRule { search, replace });
    }
}

impl WriteRule {
    fn update(&self, target: String) -> String {
        let lines = self.search.split("\n").count();
        let mut buf: VecDeque<String> = VecDeque::new();
        let mut output: Vec<String> = Vec::new();
        for line in target.split("\n") {
            if buf.len() == lines {
                output.push(buf.pop_front().unwrap());
            }
            buf.push_back(line.to_string());
            let buf_vec: Vec<String> = buf.clone().into();
            if buf_vec.join("\n") == self.search {
                output.push(self.replace.to_string());
                buf.clear();
            }
        }
        if buf.len() > 0 {
            for line in buf {
                output.push(line.to_string());
            }
        }
        return output.join("\n");
    }
}