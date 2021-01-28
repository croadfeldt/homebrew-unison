class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.4-git.5f6a085d"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/5f6a085d9193ee1343969cd03362d797f3cc27ab.tar.gz"
  sha256 "40674561ec21501ad093cb174cb13c72e71fa6e7f5707961c4c07597304dd3a3"
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
