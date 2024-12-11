use std::collections::HashSet;
use std::time::Instant;

use anyhow::Result;

fn main() -> Result<()> {
    for arg in std::env::args().skip(1) {
        let input = std::fs::read(arg)?;
        let input = Grid::parse(input);

        let t = Instant::now();
        let p1 = part_one(&input);
        println!("Part One: {p1} ({:?})", t.elapsed());

        let t = Instant::now();
        let p2 = part_two(&input);
        println!("Part Two: {p2} ({:?})", t.elapsed());
    }

    Ok(())
}

use std::collections::HashMap;

use petgraph::algo::{all_simple_paths, has_path_connecting};
use petgraph::graph::DiGraph;
use petgraph::prelude::*;

#[derive(Debug, Copy, Clone, Eq, PartialEq, Hash)]
struct Loc {
    pos: Coord,
    node: NodeIndex,
}

#[derive(Debug, Clone)]
struct Scanner(pub HashMap<Coord, Loc>);

pub fn part_one(grid: &Grid) -> usize {
    let mut graph: DiGraph<(u8, Coord), ()> = DiGraph::new();
    let items: Vec<Scanner> = (0..=9)
        .map(|n: u8| {
            Scanner(
                grid.find(n)
                    .iter()
                    .map(|&pos| {
                        let node = graph.add_node((n, pos));
                        (pos, Loc { pos, node })
                    })
                    .collect(),
            )
        })
        .collect();

    for n in 1..=9usize {
        let pred = &items[n - 1];
        let succ = &items[n];

        for &Loc { pos, node: dest } in succ.0.values() {
            for Loc { node: src, .. } in pred.adjacent(pos) {
                graph.add_edge(src, dest, ());
            }
        }
    }

    // println!("# graph");
    // println!("{:?}", petgraph::dot::Dot::new(&graph));

    let ones = &items[0];
    let nines = &items[9];

    ones.0
        .iter()
        .map(|(_, &Loc { node: start, .. })| {
            nines
                .0
                .iter()
                .filter(|(_, &Loc { node: end, .. })| has_path_connecting(&graph, start, end, None))
                .count()
        })
        .fold(0_usize, |m, c| m + c)
}

pub fn part_two(grid: &Grid) -> usize {
    let mut graph: DiGraph<(u8, Coord), ()> = DiGraph::new();
    let items: Vec<Scanner> = (0..=9)
        .map(|n: u8| {
            Scanner(
                grid.find(n)
                    .iter()
                    .map(|&pos| {
                        let node = graph.add_node((n, pos));
                        (pos, Loc { pos, node })
                    })
                    .collect(),
            )
        })
        .collect();

    for n in 1..=9usize {
        let pred = &items[n - 1];
        let succ = &items[n];

        for &Loc { pos, node: dest } in succ.0.values() {
            for Loc { node: src, .. } in pred.adjacent(pos) {
                graph.add_edge(src, dest, ());
            }
        }
    }

    // println!("# graph");
    // println!("{:?}", petgraph::dot::Dot::new(&graph));

    let ones = &items[0];
    let nines = &items[9];

    ones.0
        .iter()
        .map(|(_, &Loc { node: start, .. })| {
            let mut paths = nines
                .0
                .iter()
                .flat_map(|(_, &Loc { node: end, .. })| {
                    all_simple_paths::<Vec<_>, _>(&graph, start, end, 1, Some(8))
                        .collect::<Vec<_>>()
                })
                .collect::<Vec<_>>();

            paths.sort_unstable();
            Vec::dedup(&mut paths);

            paths.len()
        })
        .fold(0_usize, |m, c| m + c)
}

impl Scanner {
    pub fn adjacent(&self, (x, y): Coord) -> Vec<Loc> {
        let subx = x.checked_sub(1);
        let suby = y.checked_sub(1);

        let posx = x + 1;
        let posy = y + 1;

        let cardinals = [
            suby.map(|y| (x, y)), // N
            Some((x, posy)),      // S
            Some((posx, y)),      // E
            subx.map(|x| (x, y)), // W
        ];

        cardinals
            .into_iter()
            .filter_map(|m| m.and_then(|coord| self.0.get(&coord)).copied())
            .collect()
    }
}

#[cfg(test)]
mod part_one {
    use super::*;

    #[test]
    fn test_large() {
        let input = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/test2"));
        let input = Grid::parse(input);
        assert_eq!(part_one(&input), 36);
    }

    #[test]
    fn test_small() {
        let input = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/test1"));
        let input = Grid::parse(input);
        assert_eq!(part_one(&input), 1);
    }
}

#[cfg(test)]
mod part_two {
    use super::*;

    #[test]
    fn test_large() {
        let input = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/test2"));
        let input = Grid::parse(input);
        assert_eq!(part_two(&input), 81);
    }

    #[test]
    fn test_small() {
        let input = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/test3"));
        let input = Grid::parse(input);
        assert_eq!(part_two(&input), 3);
    }
}

pub struct Grid {
    pub pitch: usize,
    pub elems: Vec<u8>,
}

pub type Coord = (usize, usize);

impl Grid {
    fn parse(data: impl AsRef<[u8]>) -> Self {
        let data = data.as_ref();
        let lines = data.split(|&n| n == '\n' as u8);

        let pitch = lines
            .clone()
            .next()
            .map(|l| l.len())
            .expect("input must be delimited by lines");

        let cap = (data.len() / (pitch + 1) + 1) * pitch;
        let mut elems = Vec::with_capacity(cap);
        for line in lines {
            elems.extend_from_slice(line);
        }
        for elem in elems.as_mut_slice() {
            *elem -= '0' as u8;
        }

        Self { pitch, elems }
    }

    pub fn coord(&self, index: usize) -> Coord {
        let x = index % self.pitch;
        let y = index / self.pitch;
        (x, y)
    }

    pub fn find<'a>(&self, needle: u8) -> HashSet<Coord> {
        self.elems
            .iter()
            .copied()
            .enumerate()
            .filter(|(_, elem)| *elem == needle)
            .map(|(index, _)| {
                let x = index % self.pitch;
                let y = index / self.pitch;
                (x, y)
            })
            .collect()
    }

    pub fn at(&self, (x, y): Coord) -> Option<u8> {
        self.elems.get(x + y * self.pitch).copied()
    }
}
