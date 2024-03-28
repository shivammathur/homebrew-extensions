# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9fae55f5db8e9c1d659cdeb1b0b24cb35e56b780.tar.gz?commit=9fae55f5db8e9c1d659cdeb1b0b24cb35e56b780"
  version "8.4.0"
  sha256 "53a75acd4c4a5ba2ed08d9deb5e368ba44aae8d80517c6c2c37ea7ae7d05a982"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 35
    sha256 cellar: :any,                 arm64_sonoma:   "eccad9b25b3bbc5a2c93d834353eb1a05640eda4a8e02d50036441e16e28e7ba"
    sha256 cellar: :any,                 arm64_ventura:  "84af6c1fe10e3f9a5a6939a755225d82321282b9a154e8ded202b94a5811bcc3"
    sha256 cellar: :any,                 arm64_monterey: "f16e3651d11b9d27482cc88376570f8e6c14639190a9f27f95aaff1cbc2e499c"
    sha256 cellar: :any,                 ventura:        "fe008c73e671f8722bf8206bf3dab97c81b53d1d7b45961335eb37ab3f1d6180"
    sha256 cellar: :any,                 monterey:       "455f77b9212f0bb1229afd5b1e0a6dd035747d4980bc0a79d2cfb2ba9176122e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66f4c024818d8064007ddd31f3238b46a4cc2b217e919cfb20f508fc9cc0e3da"
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
