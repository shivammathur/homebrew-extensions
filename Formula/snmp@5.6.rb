# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2e922830b542a067a306870dffd20040f34fb05c.tar.gz"
  version "5.6.40"
  sha256 "04c58a4a21c99f3a8df74c37141231691497ebf50a5dce3479f168de7b6f3a5e"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "e09a14c921428dd78df9ab61ece562c8961a374a28447cc3f1923d4a4b7c7031"
    sha256 cellar: :any, arm64_tahoe:       "9dcad5ac83f1b902161830c501a4618fcd9905a86f2836bee01104397dfe609f"
    sha256 cellar: :any, arm64_sequoia:     "0c10a865b573771c5397228a078df25dd82420141dbae391ab2c7321a6d21544"
    sha256 cellar: :any, arm64_linux:       "32c646d0f5f1a8ffebe9783ba2df40694c7ac2f4df853c4347657540493e7d49"
    sha256 cellar: :any, x86_64_linux:      "3989e4e4e1be7a9497b6f91e79f730e64b8ba41b2a0783e3cae3f10592ba0be2"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
