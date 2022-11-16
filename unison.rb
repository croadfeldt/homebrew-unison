class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.53.0-git.f3f7972"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/f3f7972bdab2770ea3085fad06c7939c2233ff7c.tar.gz"
  sha256 "d59170f014e0b01b9434d3f17dd52de1397dcbdd1a4d1862652ac15439b33464"
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
