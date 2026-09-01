Ja, Rust hat mehrere Konzepte, die Python Comprehensions ähneln, hauptsächlich über **Iterator-Methoden** und **Closures**:

## Iterator-Methoden (häufigste Alternative)

**List Comprehension Äquivalent:**

```rust
// Python: squares = [x**2 for x in range(10)]
let squares: Vec<i32> = (0..10).map(|x| x * x).collect();
```

**Mit Filterung:**

```rust
// Python: evens = [x for x in range(20) if x % 2 == 0]
let evens: Vec<i32> = (0..20).filter(|&x| x % 2 == 0).collect();
```

**Kombiniert (map + filter):**

```rust
// Python: [x**2 for x in range(10) if x % 2 == 0]
let even_squares: Vec<i32> = (0..10)
    .filter(|&x| x % 2 == 0)
    .map(|x| x * x)
    .collect();
```

## HashMap (Dictionary Comprehension Äquivalent)

```rust
use std::collections::HashMap;

// Python: {word: len(word) for word in ['rust', 'python', 'go']}
let word_lengths: HashMap<&str, usize> = ["rust", "python", "go"]
    .iter()
    .map(|&word| (word, word.len()))
    .collect();
```

## HashSet (Set Comprehension Äquivalent)

```rust
use std::collections::HashSet;

// Python: {x**2 for x in [1, 2, 2, 3, 3]}
let unique_squares: HashSet<i32> = [1, 2, 2, 3, 3]
    .iter()
    .map(|&x| x * x)
    .collect();
```

## Vec-Makro für einfache Fälle

```rust
// Für sehr einfache Fälle
let numbers = vec![1, 2, 3, 4, 5];
```

**Rust's Ansatz** ist funktionaler und typsicherer, aber etwas verbosER als Python's Comprehensions. Die `.map()`, `.filter()`, und `.collect()` Kette ist das idiomatische Rust-Äquivalent.