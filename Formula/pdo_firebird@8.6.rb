# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_tahoe:   "15304c2957c41be4dda851c5acf737be80015a832d6ef889471bb11a0180683b"
    sha256 cellar: :any,                 arm64_sequoia: "696fe128ec39bd66f126ba887af357bb9830e9ad0c7b6c1762c13fa6e38a28c0"
    sha256 cellar: :any,                 arm64_sonoma:  "64ed3d633667aa7e1ec06ce3008964c9ba749622539203250bafe909133eb52c"
    sha256 cellar: :any,                 sonoma:        "c867b68ec9ea2f0b6e333fad5c04fe2b17abf1186efb1eb46c7f2b098f0a734d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0bccb3f6382bcb2874a7ad855968afdcf3a8852cb26a6f516922a4263441ff08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b196d1b49f159559d27200323cce9c9a34b7a6c8740447ea100a9e561d965780"
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
