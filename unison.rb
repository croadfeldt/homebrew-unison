class Unison < Formula
  desc "File synchronization tool for OSX"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/26a29f79487484b7982c85e0dc879cf7aaaf584f.tar.gz"
  sha256 "4b5dd5af7354cce25b261d0e7106df76b2d0386898f78e0ab952580907e9c757"
  head "https://github.com/bcpierce00/unison.git", :branch => "master"

  depends_on "ocaml" => :build

  # Version bump to 2.51.3
  patch do
    url "https://github.com/bcpierce00/unison/commit/26a29f7.diff?full_index=1"
    sha256 "a7f2da810599c1990ba8c7fb70c2b7723aae8543170707c45f4ac7a6ee0f4645"
  end

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
