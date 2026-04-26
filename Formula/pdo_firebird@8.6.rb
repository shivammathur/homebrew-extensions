# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a935460721865969e628079366a4343b5bd4870b.tar.gz?commit=a935460721865969e628079366a4343b5bd4870b"
  version "8.6.0"
  sha256 "00b503efd45e8174a9bb1736b22204973c7bc21da99aeb50ef96b44b820ea916"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_tahoe:   "8b5aa5aa3897fef997518fd2890599d90ad4cc3ffdfd0f0bcad6db1586715125"
    sha256 cellar: :any,                 arm64_sequoia: "a6898b8172d0708d5f18d3b43e5dac39466e9320dd7e00863674915524ce5e4e"
    sha256 cellar: :any,                 arm64_sonoma:  "12ee3e796f484ca3b0ebc4733b8eb356248c249524222937494e37cb783da13e"
    sha256 cellar: :any,                 sonoma:        "68100942d666ddd4947d29bc0e5af204d65b6a247dc856e196fbf3cd4ba91b5d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "65d9dcd0690e7d19c88f24223f81a77762472769807d6332b2a5938592fe35e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8bcd0e9fe73bef35c4b9ae6fb47359a14cf638b5f4a31f1d6bcd7432da56eea1"
  end

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
