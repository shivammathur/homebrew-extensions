# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_tahoe:   "664d98f15a6adca063cf2e764159605e32830d05dd1603924260ba02e4aa9fe8"
    sha256 cellar: :any,                 arm64_sequoia: "1c0b452a11d0f19daced705f36c5addbfd7dce088b2a537ebebb5c51d69c59c1"
    sha256 cellar: :any,                 arm64_sonoma:  "0bec377a46e9cdf298c222953655336bed45dce77d4ce5b9d5b4a387d8137fb5"
    sha256 cellar: :any,                 sonoma:        "fe0f60cc3217ca567140a27fc5dcc73adcd9801591770a450dd7fdb8fb2d4b93"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e33ace16a8e508b0a46b932b3696f7fe74778b85b7d3710899889cc3f80cf279"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50f2a9f59df520a0a776c699e36c6881a9349dedf951d4ca65a9b19cf1415b8b"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1195f271d068e57f692027a6e293865e97495eca.tar.gz?commit=1195f271d068e57f692027a6e293865e97495eca"
  version "8.6.0"
  sha256 "efae80153302629dcc3c2abbd58caa86ebfe52d42978857ba74709d817214e27"
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
