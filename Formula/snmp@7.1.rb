# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4cd450adf633ff3b756586f5ce8fb31a7c7f8359.tar.gz"
  version "7.1.33"
  sha256 "632a98f29d7e023b0dc4d3ae9680877f8f7aafed162345ca3318f5e9d1f87db7"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2044ad5ac0c8e0bc7d0ef23845bed6be5086c971dc5f4204bf5f1a3d9919ea40"
    sha256 cellar: :any,                 arm64_sequoia: "8c0f3fe221828d3e37b47dc80b4eaa4f58ebfd26cf55131bb3edee28fd0969c2"
    sha256 cellar: :any,                 arm64_sonoma:  "625143fd1a0b9f7b99060ac0490d5151e38fba83fd19f233f757b1980bc4ce26"
    sha256 cellar: :any,                 sonoma:        "c06952a1fe016dc23aec600b043b6206056b81c483cd0ea062846d8aa47d6b74"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad4681c1a4c17ba2fde6d04487fdd6ce8e80031394db1af87a844ef1955045f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6a8973212993a9cbea6ce414f158f67f65cad603d70422151145cc082064194"
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
