# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1bbd8eb28df63c4bdf77a11c29d4c1679a20315f975c3a7b8dc09e17bcb0a78d"
    sha256 cellar: :any,                 arm64_sequoia: "d93b7994638e2ab21c1287afe76117bb97dbc6a355c33422bceb6ec5c2ab97b3"
    sha256 cellar: :any,                 arm64_sonoma:  "93cb774a6b3167443ec3e38d359d89ba6dbeadb59f1564d388722e9b8a9731ee"
    sha256 cellar: :any,                 sonoma:        "a6b8bda47e177e550195166a4c0bb55b18b1a080ccfa8028bdf32a26ed024fc5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a17cafdbe499d7c91301145dc4a3192d3842b0030da0d8b54596b1001bc40be1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b975ea94835047167ded379bff057d9694a3e598a5404ae2872d49f657d975fe"
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
