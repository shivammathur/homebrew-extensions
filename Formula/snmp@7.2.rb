# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "731e6ea4e4c8c95021027a81b64feb6b8ebeaf0d1966c1e9f5ccfc6ca7a3f0f0"
    sha256 cellar: :any, arm64_tahoe:       "05b792e400d9b6d45ae58bc3d8273a11d851877d0c81bd4750ab9adb0223a979"
    sha256 cellar: :any, arm64_sequoia:     "eb902baa8decccec8d425a4a8d6c91573e353d92aee15fde351496e833ffc381"
    sha256 cellar: :any, arm64_linux:       "e26e27bcfab06ea32d0baa1538b1b506d97834ac367053625a585bda8cbd3342"
    sha256 cellar: :any, x86_64_linux:      "07182e43807187c12bee7e8cd8a06c40ca7e0946d8dc1f5de93b1faa7da0db52"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
