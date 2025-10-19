# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2caa81b25793a7c1878530ed80a289b070cfa44f.tar.gz"
  version "5.6.40"
  sha256 "b3397170680a3fe9f1ba36298794af232f76c1eb6d647cd0fe5581a5f233ffc3"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "639a06385173d84010c10468d56eb411884d7c576ee6882ded6005400f4a9b4b"
    sha256 cellar: :any,                 arm64_sonoma:  "6c460d104b90c5ba7f2d1fbf7687a344608e9338f2a299e5a43e5989b4c25204"
    sha256 cellar: :any,                 arm64_ventura: "42a04e1f31c6efb4f6326691c6a770ece234807aaffb3b2af39c01b7d868ad73"
    sha256 cellar: :any,                 sonoma:        "01dfae16b5317b5e1d2a65096ad5271cc93e649bd663df76fcd8004741807d25"
    sha256 cellar: :any,                 ventura:       "edae5d1ea13d49dfaed3e650a56976a2888c58452ff5fd906d015619c176b135"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c73f0f13904e823ce102e03d0bf2d31e375fadf179f33cf82ede1752d034ba99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6c2f0bcf5d632b2a9b194ed0e5016075c3693453593dac4001c714616569d48"
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
