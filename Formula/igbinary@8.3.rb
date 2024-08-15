# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "23ccb3cf282cd62acf70166e9c18c3684adb939b0a1c15ae3354989a0f25830b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1ada72aec5ac60ef0ba446c8accfab862e43cb24b668a3a41f238daefc6843e6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "93ef09a4b96a7c0da6abe35f4ff4b4885ede39287b60cdbe5b72ce65d652e950"
    sha256 cellar: :any_skip_relocation, ventura:        "c43ea4c90b837f22380edbcca700a958cdfb6c6875be33a54b65249e7c0e8ae3"
    sha256 cellar: :any_skip_relocation, monterey:       "57a6bf1436c42b8b6b09877fad60e4aea9bfa346d2c74ee0a9c51cff6ad3f4a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f5493f5e1c85ede4eae4ad4ba12c2a65020e78380be27b7a03c79e73346edd0"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
