# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.8.tar.xz"
  sha256 "cfe1055fbcd486de7d3312da6146949aae577365808790af6018205567609801"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "524146597672597501fbe1c49e7fe7a791b00a1a5c4a19bfadfd7e708f96547a"
    sha256 cellar: :any,                 arm64_big_sur:  "6437c52192480ae6dfaa71bc2c0a88c96cb32a65588bf757d0de1a468a176e6f"
    sha256 cellar: :any,                 ventura:        "ad60c5af4a8b4865b62c7191a8705b5d2a180ea82f938e08683fb588a1510e4d"
    sha256 cellar: :any,                 monterey:       "3090f1f05d27d9c2248ebbef0cda9305f7984470764b507f74a2c4ce42f6bb5b"
    sha256 cellar: :any,                 big_sur:        "0a225a4e387bdcb17da9c5cb88539c12e0a59c9431837dd1629ed0e70539852e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6433d58943b4742f83c681bfd106c5ddaf03d3c7030a6d1b5e806be26ce74b6"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
