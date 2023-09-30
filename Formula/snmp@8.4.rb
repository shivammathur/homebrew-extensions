# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0b7a0e9f414cf40183a7ab53dacb8979e192350c.tar.gz?commit=0b7a0e9f414cf40183a7ab53dacb8979e192350c"
  version "8.4.0"
  sha256 "3baa53f8cece6cdce5b71b6d0c6427da8fcd5e6ae4729bc5ca60333e506f1fe6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "3db77fa4a5a9f01cb243aeddf86e3b0c94354642262fe3cc77de94899faebc2e"
    sha256 cellar: :any,                 arm64_ventura:  "c2c94bae2ed0117e51a13449401dcc3f6d4e8e4a0f22eb89bae9cbee8c31a360"
    sha256 cellar: :any,                 arm64_monterey: "d350fe66c3d4016aa5ba13fe400ea8ba51bbb825a37227bb44186ef8213c7652"
    sha256 cellar: :any,                 ventura:        "8fe71b331b79bc2438e0a929a2ed3dfee5b8e965f7b751c5415cb86abaefde9b"
    sha256 cellar: :any,                 monterey:       "3db3c922f8e6d5b226dff412bc8f3bfdca86274f3c446647f0f02ca3fb43d78f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "950b6e5caefdc44ae7baa77233eb5129a673d8bc1fffb78e967cb249ca6c5ee2"
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
