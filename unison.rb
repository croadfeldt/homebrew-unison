class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.4-git.a881780"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/a881780c8bfced48dcc0ed83130ef9e3487a36aa.tar.gz"
  sha256 "cfe64752ff55d724338fc40195bd695ad70d0e4735b31d2d7fd971af20826000"
  head "https://github.com/bcpierce00/unison.git", :branch => "master"

  depends_on "croadfeldt/ocaml/ocaml" => :build

  def install
    ENV.deparallelize
    ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
    ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
    system "make", "UISTYLE=text"
    bin.install "src/unison"
    prefix.install_metafiles "src"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unison -version")
  end
end
