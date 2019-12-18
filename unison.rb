class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.3-git.26a29f7"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/26a29f79487484b7982c85e0dc879cf7aaaf584f.tar.gz"
  sha256 "4b5dd5af7354cce25b261d0e7106df76b2d0386898f78e0ab952580907e9c757"
  head "https://github.com/bcpierce00/unison.git", :branch => "master"

  depends_on "ocaml" => :build

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
