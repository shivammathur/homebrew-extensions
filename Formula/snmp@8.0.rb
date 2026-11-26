# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5d85325de4b739456646af9ac824015bb250b293.tar.gz"
  sha256 "03b3915a8a35907eac68dd93013896677fc73c23f70cd538fdbd477098bd3481"
  version "8.0.30"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "c64a1016534b215921537bcc687e70f70ae721d1cf20c42cb5dd79275e608afc"
    sha256 cellar: :any, arm64_golden_gate: "ddcbb00ea84208765e2e0d85cf961dfae9f5b73b202a65f00b21ef41782005d6"
    sha256 cellar: :any, arm64_tahoe:       "dd1e905cf9681d72215f5d930a49e0522dee803c68aa7284f71227f4d7af0e95"
    sha256 cellar: :any, arm64_sequoia:     "109e5d227ee92aacbff22a0be60685d190103a700e7ba21fee561c96f86cff36"
    sha256 cellar: :any, arm64_linux:       "90e961386d514eba1cd3b92de9538d3264290311ebf78ee11dc3e7f4e019239e"
    sha256 cellar: :any, x86_64_linux:      "41056bc4a93d6602a83421c5055dd92b02c68bd8940c8529adc1b0aa9dd769f1"
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
