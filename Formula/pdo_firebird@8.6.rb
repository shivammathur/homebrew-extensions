# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "4aea81a312f171aa09510ecb3a761d30a5b94e1f7c211930cfbfa780db372af6"
    sha256 cellar: :any,                 arm64_sequoia: "6a374a99feec49ae9b8ba30e4dc92ddf054445720b22ffde066cfbae89eb412a"
    sha256 cellar: :any,                 arm64_sonoma:  "6e7afaad29d6fb97081bcb14a2bb4b026fe9b5eeff8986379a04786601b10364"
    sha256 cellar: :any,                 sonoma:        "1b7411d539a274146d7aeba706b1069f21fb54112986ee28dce2474ced606964"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fd1e453d4d88ba5985331725533c9034beb59232d47a31fc012055fdaafc6e73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75a6c255fcf30030cd812ef3a7842281ab339261cfe3e806539637e9e44a9bde"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ab043eefa4beac47f70036904f545a29c6253871.tar.gz?commit=ab043eefa4beac47f70036904f545a29c6253871"
  version "8.6.0"
  sha256 "faa0cffecf83d29fbade4add80001bd01d4211582bdf2438269533d0bb551d85"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
