# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7ff78f7b101c02717356c0b57722a8abad0cd7fd.tar.gz?commit=7ff78f7b101c02717356c0b57722a8abad0cd7fd"
  version "8.4.0"
  sha256 "d28cfda1af25ed0fcab0ee0347b77c2adc51eaacb91ed7a3b9b26b23d7ecc9eb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 32
    sha256 cellar: :any,                 arm64_sonoma:   "bf8d6064c92cb175b4bc5990bc12cde1bc1e893a89647e9d7de4adb0f3902da6"
    sha256 cellar: :any,                 arm64_ventura:  "37c00b039217c7aba0fa4ad2a9ef4fabf2aa30a5c2658b53fb9eb6c681ece5f4"
    sha256 cellar: :any,                 arm64_monterey: "9fead150c39d851c7f1a3e97be06dadc0978b0d235d34fef8c0c576cdffa3d60"
    sha256 cellar: :any,                 ventura:        "97a345038a9aadeb9947adba34b0ddd33238e56306c2bfbb05f0ffb432b860e5"
    sha256 cellar: :any,                 monterey:       "b9d1ef263fe91e22f4b5acaf744b54cc7842b60019dc6e3f9e1b442566b163af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "930dfc803ba4e2db885f3ed681bf6b2e78fe778dd37c153364ade28bbf79953f"
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
