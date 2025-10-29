#pdf.embed(
  "./hw-2.typ",
  description: "typst source code",
  relationship: "source",
  mime-type: "text/x-typst",
)

#import "@preview/cetz:0.4.2"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

#import sym: arrow
#set text(size: 12pt, font: "DejaVu Serif")
#set page(numbering: "1 / 1", margin: auto)
#set page(header: context {
  if counter(page).get().first() == 1 {
    grid(
      columns: (1fr, 1fr),
      gutter: 0.5em,
      [Adrian Valcarcel-Schott], align(right)[Professor Srilekha Dodda],
      datetime.today().display("[month repr:long] [day], [year]"), align(right)[CS 3502 Operating Systems],
    )
  }
})

#show heading: set text(weight: 500)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 2): set align(center)
#show heading.where(level: 2): set block(below: 1.2em)
#show heading.where(level: 3): set block(below: 1.2em)
#show heading.where(level: 3): emph
#show raw.where(block: false): set text(size: 1.2em, font: "Jetbrains Mono")
#set par(justify: true)
#show link: underline.with(offset: 1.5pt)
#show figure.caption: emph
// #show figure.caption: set text(size: 0.3em)
// #set figure(supplement: none)
#show figure: set figure.caption(position: top)
#show figure.caption: set align(right)
#show figure.caption.where(kind: table): set align(left)

#show: codly-init.with()

#codly(languages: codly-languages)

#show raw.where(lang: "bash"): local.with(zebra-fill: none, number-format: none)
#show raw.where(lang: "strace"): local.with(display-name: false, display-icon: false)

#let diagram(canvas, ..rest) = {
  figure(
    supplement: "Gantt Chart",
    kind: "cpu-gantt",
    context {
      let canvas-size = measure(canvas)
      layout(size => {
        // scale(origin: left, size.width / canvas-size.width * 100%, canvas)
        scale(origin: center, size.width / canvas-size.width * 100%, canvas)
      })
    },

    ..rest,
  )
}

= Homework II

== Question 1


#diagram(
  caption: [First Come First Serve (FCFC)],
  cetz.canvas({
    import cetz.draw: *

    let gray = gray.lighten(65%)

    rect((0, 0), (5, 1.2), fill: gray, name: "P1")
    rect((5, 0), (8, 1.2), fill: gray, name: "P2")
    rect((8, 0), (9, 1.2), fill: gray, name: "P3")
    rect((9, 0), (16, 1.2), fill: gray, name: "P4")
    rect((16, 0), (20, 1.2), fill: gray, name: "P5")

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.1em, font: "Liberation Mono")
        b
      },
      ..rest,
    )

    content("P1.south-west", [0], padding: (top: 1.5em))
    content("P1.south-east", [5], padding: (top: 1.5em))
    content("P2.south-east", [8], padding: (top: 1.5em))
    content("P3.south-east", [9], padding: (top: 1.5em))
    content("P4.south-east", [16], padding: (top: 1.5em))
    content("P5.south-east", [20], padding: (top: 1.5em))

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.35em)
        set sub(typographic: false, size: 0.7em, baseline: 0.35em)
        emph(b)
      },
      ..rest,
    )

    content("P1", [P#sub[1]])
    content("P2", [P#sub[2]])
    content("P3", [P#sub[3]])
    content("P4", [P#sub[4]])
    content("P5", [P#sub[5]])
  }),
)


#diagram(
  caption: [Shortest Job First (SJF)],
  cetz.canvas({
    import cetz.draw: *

    let gray = gray.lighten(65%)

    rect((0, 0), (1, 1.2), fill: gray, name: "P3")
    rect((1, 0), (4, 1.2), fill: gray, name: "P2")
    rect((4, 0), (8, 1.2), fill: gray, name: "P5")
    rect((8, 0), (13, 1.2), fill: gray, name: "P1")
    rect((13, 0), (20, 1.2), fill: gray, name: "P4")

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.1em, font: "Liberation Mono")
        b
      },
      ..rest,
    )

    content("P3.south-west", [0], padding: (top: 1.5em))
    content("P3.south-east", [1], padding: (top: 1.5em))
    content("P2.south-east", [4], padding: (top: 1.5em))
    content("P5.south-east", [8], padding: (top: 1.5em))
    content("P1.south-east", [13], padding: (top: 1.5em))
    content("P4.south-east", [20], padding: (top: 1.5em))

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.35em)
        set sub(typographic: false, size: 0.7em, baseline: 0.35em)
        emph(b)
      },
      ..rest,
    )

    content("P1", [P#sub[1]])
    content("P2", [P#sub[2]])
    content("P3", [P#sub[3]])
    content("P4", [P#sub[4]])
    content("P5", [P#sub[5]])
  }),
)


#diagram(
  caption: [Priority (Non-preemptive)],
  cetz.canvas({
    import cetz.draw: *

    let gray = gray.lighten(65%)

    rect((0, 0), (5, 1.2), fill: gray, name: "P1")
    rect((5, 0), (9, 1.2), fill: gray, name: "P5")
    rect((9, 0), (10, 1.2), fill: gray, name: "P3")
    rect((10, 0), (17, 1.2), fill: gray, name: "P4")
    rect((17, 0), (20, 1.2), fill: gray, name: "P2")


    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.1em, font: "Liberation Mono")
        b
      },
      ..rest,
    )

    content("P1.south-west", [0], padding: (top: 1.5em))
    content("P1.south-east", [5], padding: (top: 1.5em))
    content("P5.south-east", [9], padding: (top: 1.5em))
    content("P3.south-east", [10], padding: (top: 1.5em))
    content("P4.south-east", [17], padding: (top: 1.5em))
    content("P2.south-east", [20], padding: (top: 1.5em))

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.35em)
        set sub(typographic: false, size: 0.7em, baseline: 0.35em)
        emph(b)
      },
      ..rest,
    )

    content("P1", [P#sub[1]])
    content("P2", [P#sub[2]])
    content("P3", [P#sub[3]])
    content("P4", [P#sub[4]])
    content("P5", [P#sub[5]])
  }),
)


#diagram(
  caption: [Round Robin (RR)],
  cetz.canvas({
    import cetz.draw: *


    let gray = gray.lighten(65%)

    rect((0, 0), (2, 1.2), fill: gray, name: "P1_1")
    rect((2, 0), (4, 1.2), fill: gray, name: "P2_1")
    rect((4, 0), (5, 1.2), fill: gray, name: "P3")
    rect((5, 0), (7, 1.2), fill: gray, name: "P4_1")
    rect((7, 0), (9, 1.2), fill: gray, name: "P5_1")
    rect((9, 0), (11, 1.2), fill: gray, name: "P1_2")
    rect((11, 0), (12, 1.2), fill: gray, name: "P2_2")
    rect((12, 0), (14, 1.2), fill: gray, name: "P4_2")
    rect((14, 0), (16, 1.2), fill: gray, name: "P5_2")
    rect((16, 0), (17, 1.2), fill: gray, name: "P1_3")
    rect((17, 0), (19, 1.2), fill: gray, name: "P4_3")
    rect((19, 0), (20, 1.2), fill: gray, name: "P4_4")


    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.1em, font: "Liberation Mono")
        b
      },
      ..rest,
    )

    content("P1_1.south-west", [0], padding: (top: 1.5em))
    content("P1_1.south-east", [2], padding: (top: 1.5em))
    content("P2_1.south-east", [4], padding: (top: 1.5em))
    content("P3.south-east", [5], padding: (top: 1.5em))
    content("P4_1.south-east", [7], padding: (top: 1.5em))
    content("P5_1.south-east", [9], padding: (top: 1.5em))
    content("P1_2.south-east", [11], padding: (top: 1.5em))
    content("P2_2.south-east", [12], padding: (top: 1.5em))
    content("P4_2.south-east", [14], padding: (top: 1.5em))
    content("P5_2.south-east", [16], padding: (top: 1.5em))
    content("P1_3.south-east", [17], padding: (top: 1.5em))
    content("P4_3.south-east", [19], padding: (top: 1.5em))
    content("P4_4.south-east", [20], padding: (top: 1.5em))

    let content(a, b, ..rest) = cetz.draw.content(
      a,
      {
        set text(size: 1.35em)
        set sub(typographic: false, size: 0.7em, baseline: 0.35em)
        emph(b)
      },
      ..rest,
    )

    content("P1_1", [P#sub[1]])
    content("P1_2", [P#sub[1]])
    content("P1_3", [P#sub[1]])

    content("P2_1", [P#sub[2]])
    content("P2_2", [P#sub[2]])

    content("P3", [P#sub[3]])

    content("P4_1", [P#sub[4]])
    content("P4_2", [P#sub[4]])
    content("P4_3", [P#sub[4]])
    content("P4_4", [P#sub[4]])

    content("P5_1", [P#sub[5]])
    content("P5_2", [P#sub[5]])
  }),
)

#figure(
  caption: [Turnaround Times],
  table(
    stroke: none,
    fill: (_, y) => if calc.odd(y) { luma(240) } else { white },
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    rows: 6,
    table.header([*Process*], [*FCFS*], [*SJF*], [*Priority*], [*RR*]),
    table.hline(),

    [P#sub[1]], [5], [13], [5], [17],
    [P#sub[2]], [8], [4], [20], [12],
    [P#sub[3]], [9], [1], [10], [5],
    [P#sub[4]], [16], [20], [17], [20],
    [P#sub[5]], [20], [8], [9], [16],
  ),
)

#figure(
  caption: [Waiting Times],
  table(
    stroke: none,
    fill: (_, y) => if calc.odd(y) { luma(240) } else { white },
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    rows: 7,
    table.header([*Process*], [*FCFS*], [*SJF*], [*Priority*], [*RR*]),
    table.hline(),

    [P#sub[1]], [0], [8], [0], [12],
    [P#sub[2]], [5], [1], [17], [9],
    [P#sub[3]], [8], [0], [9], [4],
    [P#sub[4]], [9], [13], [10], [13],
    [P#sub[5]], [16], [4], [5], [12],
    [avg], [7.6], [5.2], [8.2], [10],
  ),
)

It is clear that SJF gives the minimum average waiting time in this case.


== Question 2

=== Compilation and Execution

The program source code is a single `c` file. The file is embedded in this pdf document as `file-copy.c`. The file will also be attached to the assignment submission.

#pdf.embed(
  "./file-copy.c",
  description: "program source code",
  relationship: "supplement",
  mime-type: "text/x-c",
)

The program can be compiled using your favorite C-standard compliant compiler on any POSIX compliant system, and executed as any other program would be:


```bash
# compile source to ./file-copy
# - `cc` is the system C compiler
# - `./file-copy.c` specifies a source file compile
# - `-o ./file-copy` specifies the output executable
# - '-O3` enables more performance optimizations
cc ./file-copy.c -o ./file-copy -O3

# copy source.txt to dest.txt
./file-copy source.txt dest.txt
```

// The program also ensures that the file is created with the same permissions as the original file. This means that, for example, a copy of an executable file is also executable.

// ```bash
// # make a copy of ourselves
// ./file-copy ./file-copy ./file-cp

// # the copy is also executable
// ./file-cp source.txt dest.txt
// ```

=== Sample Trace I

For the first sample trace, a small hardcoded text file was used.

```bash
# first, write our source.txt file
cat <<EOF > source.txt
In Section 2.3(see textbook), we described a program that copies the contents of one file to a destination file. This program works by first prompting the user for the name of the source and destination files. Write this program using either the POSIX or Windows API. Be sure to include all necessary error checking, including ensuring that the source file exists. Once you have correctly designed and tested the program, if you used a system that supports it, run the program using a utility that traces system calls. Linux systems provide the strace utility, and macOS systems use the dtruss command. (The dtruss command, which actually is a front end to dtrace, requires admin privileges, so it must be run using sudo.)
EOF

# then run the trace on the small file
strace -o small.strace ./file-copy source.txt dest.txt

# make sure the two files are identical
cmp source.txt dest.txt
```

=== Observations I

The trace file begins with many irrelevant syscalls, due to CRT initialization. In this case, this initialization is reflected in the first 31 lines of `small.strace`. The full `small.strace` file is embedded in this PDF document. For brevity, relevant `strace` output is provided below:

#figure(
  {
    codly-range(31, end: 38)
    show raw: set text(size: 8pt)
    raw(block: true, lang: "strace", read("./small.strace"))
  },
  caption: `small.strace`,
)


#pdf.embed(
  "./small.strace",
  relationship: "data",
  mime-type: "text/x-strace",
  description: "strace output for first file",
)

We see first a call to `newfstatat`, which corresponds to the `stat` call used on line 78 to get the file information for the source file.


#figure(
  {
    codly-range(78, end: 78)
    raw(block: true, lang: "c", read("./file-copy.c"))
  },
  caption: [`stat` call, `file-copy.c:78`],
)

Next, we see two calls to `openat`, one for `"source.txt"` and one for `"dest.txt"`. This corresponds to the `open` calls on lines 84 and 94.

#figure(
  {
    codly-range(83, end: 101)
    raw(block: true, lang: "c", read("./file-copy.c"))
  },
  caption: [`open` calls, `file-copy.c:83-101`],
)

Note that the two calls to `openat` return 3 and 4 respectively; These denote the file descriptor values stored in `source` and `dest`, which will be used later on.

Then, we see a call to `read` and a call to `write`. Notice that the file descriptor passed to `read` is 3, and the file descriptor passed to `write` is 4. We see that we are passing the previously opened file descriptors. Also note that for the `read` syscall, the specified size is `4096`. This corresponds to `stat.st_blksize`, the optimal block size for I/O for the source file. We retrieved this in the `stat` call earlier. Finally, notice that the `read` call returns `723`, which is the size of the source file. This value is then passed to the `write` call, so we only write as much as we read.


#figure(
  {
    codly-range(13, end: 13, (21, 21))
    // codly-skip(14, 20 - 14)
    raw(block: true, lang: "c", read("./file-copy.c"))
  },
  caption: [`read` and `write` calls, `file-copy.c:13,21`],
)

Since the entire file was written with one call to `read` and `write`, the call to `copy_file` returns. Now, the program proceeds to cleanup the files before exiting. In order to cleanup the file descriptors, the `close` function is used, which calls the `close` syscall.

Again, we see that 3 and 4 are passed as the values for the file descriptors, since these were returned from the calls to `open`.

#figure(
  {
    codly-range(105, end: 106)
    // codly-skip(14, 20 - 14)
    raw(block: true, lang: "c", read("./file-copy.c"))
  },
  caption: [`close` calls, `file-copy.c:105-6`],
)

Finally, `main` returns 0, and the CRT exits the process.

=== Sample Trace II

In order to see the behavior for larger files, we generate a 1GiB file of random data. As before, the resulting trace file in its entirety is available embedded in this PDF document.

```bash
# write 1GiB of random data to our source.bin file
dd if=/dev/urandom of=source.bin bs=1G count=1

# then run the trace on the large file
strace -o large.strace -s 16 ./file-copy source.bin dest.bin

# make sure the two files are identical
cmp source.bin dest.bin
```


#pdf.embed(
  "./large.strace",
  relationship: "data",
  mime-type: "text/x-strace",
  description: "strace output for second file",
)

=== Obeservations II

This results in a trace file with 524327 lines. In addition, a benchmark shows an average execution time of 2.789 s. This is in comparison to an average of 16.9 ms for POSIX `cp`. The lesson here is to use the tools that exist instead of writing your own.

#{
  // make sure it fits wihtout line breaks
  show raw: set text(size: 0.98em)

  figure(
    {
      let green = green.darken(25%)
      let blue = blue.darken(15%)
      let teal = teal.darken(30%)
      let purple = purple.darken(20%)

      // hacky hack to simulate terminal colors
      // lots of hacks here to make sure show rules
      // only apply to the correct elements

      show regex("mean|σ"): set text(fill: green)
      show regex("(2.789|0.134) s|(16.9| 0.9) ms"): set text(fill: green)

      show regex("(0.150|1.704) s"): set text(fill: blue)
      show regex("(0.1|17.5) ms"): set text(fill: blue)

      show regex("min|2.507 s|15.8 ms"): set text(fill: teal)
      show regex("max|2.996 s|20.9 ms"): set text(fill: purple)

      show regex("165.00|12.00"): set text(fill: green)
      show regex("cp source.bin dest.bin"): set text(fill: teal)
      show regex("./file-copy source.bin dest.bin"): set text(fill: purple)

      // hack so the benchmark lines arent colored
      show "Benchmark 1: ./file-copy": set text(fill: black)
      show "Benchmark 2: cp": set text(fill: black)


      local(
        zebra-fill: none,
        number-format: none,

        ```
        Benchmark 1: ./file-copy source.bin dest.bin
          Time (mean ± σ):      2.789 s ±  0.134 s    [User: 0.150 s, System: 1.704 s]
          Range (min … max):    2.507 s …  2.996 s    10 runs

        Benchmark 2: cp source.bin dest.bin
          Time (mean ± σ):      16.9 ms ±   0.9 ms    [User: 0.1 ms, System: 17.5 ms]
          Range (min … max):    15.8 ms …  20.9 ms    149 runs

        Summary
          cp source.bin dest.bin ran
          165.00 ± 12.00 times faster than ./file-copy source.bin dest.bin

        ```,
      )
    },
    caption: text(size: 0.87em)[`hyperfine --warmup 3 './file-copy source.bin dest.bin' 'cp source.bin dest.bin'`],
    kind: "benchmark",
    numbering: none,
  )
}

But that's not what we're here for. Lets look at the output of `strace`. We skip the CRT initialization as it hasn't changed. We see that the trace is nearly identical. The only difference between the two is the quantity of `read` and `write` calls.

#figure(
  {
    codly-range(31, end: 45)
    codly-skip(40, 524279)

    show raw: set text(size: 7.5pt)
    raw(block: true, lang: "strace", read("./ltruncated.strace"))
  },
  caption: `large.strace`,
)

The 1GiB file is too large to copy in a single `read` and `write`, so we see repeated calls, from the loop in `copy_file`.

#figure(
  local({
    codly-range(
      7,
      end: 7,
      (10, 14),
      (16, 19),
      (21, 22),
      (24, 27),
      (50, 54),
    )
    raw(block: true, lang: "c", read("./file-copy.c"))
  }),
  caption: [`copy_file` implementation, `file-copy.c:`],
)
