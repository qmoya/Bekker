# Bekker

![Swift](https://github.com/qmoya/Bekker/workflows/Swift/badge.svg)

A command-line utility that reads an Aristotelian work’s XML file from Perseus, and dumps it to
the standard output in a Roam-Research-friendly format.

**Example Output**

    - [[Arist. Eth. Nic., 1094a1]] πᾶσα τέχνη καὶ πᾶσα μέθοδος, ὁμοίως δὲ πρᾶξίς τε καὶ προαίρεσις, ἀγαθοῦ τινὸς ἐφίεσθαι δοκεῖ· διὸ καλῶς ἀπεφήναντο τἀγαθόν, οὗ πάντʼ ἐφίεται. διαφορὰ δέ τις φαίνεται τῶν τελῶν· τὰ μὲν γάρ εἰσιν ἐνέργειαι, τὰ δὲ παρʼ αὐτὰσ
    - [[Arist. Eth. Nic., 1094a5]] ἔργα τινά. ὧν δʼ εἰσὶ τέλη τινὰ παρὰ τὰς πράξεις, ἐν τούτοις βελτίω πέφυκε τῶν ἐνεργειῶν τὰ ἔργα. πολλῶν δὲ πράξεων οὐσῶν καὶ τεχνῶν καὶ ἐπιστημῶν πολλὰ γίνεται καὶ τὰ τέλη· ἰατρικῆς μὲν γὰρ ὑγίεια, ναυπηγικῆς δὲ πλοῖον, στρατηγικῆς δὲ νίκη, οἰκονομικῆς δὲ πλοῦτος. ὅσαι

## Requirements

- Swift 5.3
- [`unibetacode`](https://packages.debian.org/source/buster/unibetacode)

### Installation

#### Homebrew

Run the following command to install using [Homebrew](https://brew.sh/):

```terminal
$ brew install qmoya/formulae/bekker
```

#### Manually

Run the following commands to build and install manually:

```terminal
$ git clone https://github.com/qmoya/Bekker
$ cd Bekker
$ make install
```

### Usage

    OVERVIEW: Reads an Aristotelian work’s XML file from Perseus, and dumps it to the standard output in a Roam-Research-friendly format.

    USAGE: bekker --input <input> [--path <path>] [--abbreviation <abbreviation>]

    OPTIONS:
    -i, --input <input>     An Aristotelian work’s XML file, downloaded from
                            Perseus. 
    -p, --path <path>       Path to a `beta2uni` binary. (default:
                            /usr/local/bin/beta2uni)
    -a, --abbreviation <abbreviation>
                            An abbreviation to use for the book. If absent, it
                            will use the input XML file’s basename. 
    -h, --help              Show help information.
