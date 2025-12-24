# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_tahoe:   "62221a7b919dc62c933adb3dc69426e5e12d978500b3e6950f203bdea2f563e7"
    sha256 cellar: :any,                 arm64_sequoia: "742e0e173d1baf7cc82d7589742e8448cbe26b2384b2e955e4e3e82468154f30"
    sha256 cellar: :any,                 arm64_sonoma:  "8237d663f5b24e356b52591e423e69247cb007f67d140e7ace5551c8bc7f115c"
    sha256 cellar: :any,                 sonoma:        "ce16bb208591cab9a3c62492b114a66c4d5e224dbe3a97fa7d387f9105e5910f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a8b2b02a2e8c2bf36ac56550f1e5559c7d6aa2d6c5a42436bb7e993dbf29f525"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08244e3aa89a2eda38171cba180990ff84f95e20583bb49f2d074a7a841672fc"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
