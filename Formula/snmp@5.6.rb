# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/de417b2a04e4bc04f59e3a214ac2158f8becdc4f.tar.gz"
  version "5.6.40"
  sha256 "897fe10215996e84b9db1f2a4cf9f1d11fd0ba70151e74e5adc780aebf07f2b8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia:  "7fbba7688f3833a2060e476bab48c4ddc30420d4fb230744d36e63159a062cb6"
    sha256 cellar: :any,                 arm64_sonoma:   "7624509ab5df13e03f90a2c75003dff95341be75490dc3f0bbcd2ad8d8c17e7a"
    sha256 cellar: :any,                 arm64_ventura:  "78d1f0dd64e990b8a02869570c940aa8cb38bdd1fac086b0906638aa1a809203"
    sha256 cellar: :any,                 arm64_monterey: "ea30703f6976a14e3ea73282575334a25b5db788fbffd06cdcc2c04ef193bd10"
    sha256 cellar: :any,                 ventura:        "8e4f814fc293979696d636d0b3a3d8014f42d23567dc8d7e5e75ed8979f68426"
    sha256 cellar: :any,                 monterey:       "cb73ba58512dec7dcc79490e319f3f9eb88e67f764fe8e72ee3412db91a5d129"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fbe61297eb294981ab0ea60f60b1097b65a8f964cff0c47f996b345313c5b2ef"
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
