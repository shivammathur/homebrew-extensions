# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "8443e260652ed53138a5e9db4df6c2a0b1da40eb41721ab36727954c3da82d1c"
    sha256 cellar: :any,                 arm64_monterey: "21be1469ee09fe2a746e06a339ab58e9b8981045885e24bff8972f1c19305c00"
    sha256 cellar: :any,                 arm64_big_sur:  "2fe57d08da2e6a82089db5c8a4389df5ff05bca90a911a6fecef111405ba14d3"
    sha256 cellar: :any,                 ventura:        "b768c1e90ec9a846659c5ab12ee301a1b885b76a7519cdd23495566a31eef82a"
    sha256 cellar: :any,                 monterey:       "48e37012f557d89a422836d6d408296921893176dfe79eb18a1c65e44d47a0f3"
    sha256 cellar: :any,                 big_sur:        "d80565adff048754383ebef77a3490270e146f17e7e5024edc6c7ed795b9c4d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53feb4b6a1be40471fb98cb926a7a44e953954f04f864c88cbd03af20457b8a7"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
