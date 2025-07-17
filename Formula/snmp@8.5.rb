# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2e0c011fb8d55ea1bc3e3dccb7e54f8bf3cae37e.tar.gz?commit=2e0c011fb8d55ea1bc3e3dccb7e54f8bf3cae37e"
  version "8.5.0"
  sha256 "465ee7fc77ebb754d0b6050f63323282d2c055871d05752e7680d84b57dcd292"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 34
    sha256 cellar: :any,                 arm64_sequoia: "75b4228b456e398607fc0ae801e13963bbee40c7dd2af1094e272bfffaab8e21"
    sha256 cellar: :any,                 arm64_sonoma:  "dbd6e79b4add615aab0d3a2399f3f61ce5a156aa97b9b3f48763766f247815f2"
    sha256 cellar: :any,                 arm64_ventura: "e93514ceb95c57d1a575e7cd75951749293a6ba50ce42e0cf02da55ed30c0f87"
    sha256 cellar: :any,                 ventura:       "bb6326ef6a986ea78e300599d2348e45dd7b5ac98817002c1c36bb8fc69a13e1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c613d257c29161ed3ede4015a44726a1e3f01fa6b54075cacd5745e1e6a8c459"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a97960532149d7d1d8c93ce02cc7cca3c6129beb0a2fe06d9e5f9772b61f4c81"
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
