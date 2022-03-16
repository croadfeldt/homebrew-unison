class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.5-git.3c7f38d"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/3c7f38da6985839fc2639825edba8c6421f17e61.tar.gz"
  sha256 "13c70b28982fa42f56b1f882221b53d06885e36e5c2967906d0d00a6dd1c4dd5"
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
