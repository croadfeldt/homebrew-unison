class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.52.0-git.3c314bf"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/3c314bfe7384babd0ffb99dc4b38191a13f9a6b5.tar.gz"
  sha256 "bae6b9c9a8e196fbcd4f7d45403d0da71a5d1ca0cff266d5c79f89045c54bb47"
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
