# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cd2e06066406e49a19c7dcd38050b9f47541da6a.tar.gz?commit=cd2e06066406e49a19c7dcd38050b9f47541da6a"
  version "8.6.0"
  sha256 "f66fcda598496566fbf73f50bc50323cbff7bb402dd8831cabed31d43c4918f5"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "a0ab9cc429e581321169d66770c206884b029f545c86e87fad75f90ba0ad705e"
    sha256 cellar: :any,                 arm64_sequoia: "50724d3146c7ea96b55e6f06d3ce846faf46abf60a274ea6b73bad20964025e7"
    sha256 cellar: :any,                 arm64_sonoma:  "6716ad935641393d4488e75b38baee85983b8f942943ba75b49822c074a446e3"
    sha256 cellar: :any,                 sonoma:        "4482fdb4d0ddbb1cd8d36fab74c8296ee14789de6765a655ef51b82a13eee95a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6636bdce977706e65615c8c9c9dc9b40c4e3577573a376d4c9533ddf869ee4f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d220d31475938f81f37efa7806ff0c0aff9a79b1c80344e70b190b0ad7b3cb8"
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
