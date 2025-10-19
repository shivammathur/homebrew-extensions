# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT56 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-0.13.tgz"
  sha256 "cb2cb8ab840b5b36bcd8a8df06ea4a970a61e4cb3980f3c0ac5c913522e6c1be"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "5b0ef3e47ad80393938b064c410bdee2e270ed02155fcd59560a56674dabb074"
    sha256 cellar: :any,                 arm64_ventura:  "338dd4aac429dbf1a22cede3fbad8215864428b43b5efb54c7cd270e385f9db0"
    sha256 cellar: :any,                 arm64_monterey: "0cb79d34ff59d4cef2ec107ef1b80396cedb0334374976c3d9f8a2ea3073357e"
    sha256 cellar: :any,                 arm64_big_sur:  "359c75a8055919c32a6578400ba144b865b3d116f37ef90048ef88ca430e8aea"
    sha256 cellar: :any,                 sonoma:         "c12c7f22ad6d3c03847502b2416a397c79c29f0508702a5b15383023c6a144dc"
    sha256 cellar: :any,                 ventura:        "d55b37e3f8bc751daeb197e72b77335c256e20920afcdee53bcc1a99446e4fd6"
    sha256 cellar: :any,                 big_sur:        "6b9263992d279a18d906653c877fdc8fa903e6da4dfc58981330f402f327c25f"
    sha256 cellar: :any,                 catalina:       "aede18441c3aa047413bb5fbae6910fd08496792cf555e4c9de0874476d765af"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "475007e93d5789b20efac9c7eaf2d89a53a514c0c3b1340cbec7eb3434e5d24c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "633b455750061947d1c20f3608ecf256eb097971b0e6d6d9c8f6156efd153b2b"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
