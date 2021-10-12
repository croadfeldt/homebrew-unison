class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.4-git.a39c572"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/a39c5727c9d2f7c419f2cb28f33ebd0177486969.tar.gz"
  sha256 "1b354ecda2f6a78841f3aa358a9bd4f78934bd4c7295d002a67ad8f870b5a2c1"
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
