# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fc6ec447b9214da463f512a84564324f98a70d6878e1b9fd2b70398790ddcfa8"
    sha256 cellar: :any,                 arm64_sequoia: "2b7779a92e9a3bcd41a0ccd9c985c85f415187ceb62288c4904a6df3f4fdbdf6"
    sha256 cellar: :any,                 arm64_sonoma:  "bb61a6a6c4950a53fa3d25a0bf776c9870329fb1f53e63eddc195e6390293567"
    sha256 cellar: :any,                 sonoma:        "032bacb1938f8c908b13576c25ec8bef20c3a3fcf170f0e7360a64acb6b0a8d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "db0e9f6c0480317389e5c5c711e35a7cf79d802abdb92a39c1bf5894df872da3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b87ba217bd7bf66a4373b86fec9d5617cbab95086e8579b6deb3e8c2c2405220"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/383aaa666ea5d825183dde9e676690f62f21ad88.tar.gz"
  version "7.2.34"
  sha256 "3b48ab3d2f57cc29e793846446024f7e1219641647bf1d678a5effe460358d4d"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
