class Unison < Formula
  desc "File synchronization tool for OSX"
  version "2.51.5-git.54d8e79"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/54d8e790c8f52d0ebe27a0f32a678153b3c6f31f.tar.gz"
  sha256 "b3f5e35c59fcb72f4c79bad999ed9c3ff4339968ca6b40e14434eab96e7a7c57"
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
