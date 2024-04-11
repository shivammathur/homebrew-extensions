# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5d91f8761ba93985891cd6c3181090d56b022f35.tar.gz?commit=5d91f8761ba93985891cd6c3181090d56b022f35"
  version "8.4.0"
  sha256 "3ab54c2edfdf91482136b060631f95b9046fc425d774f410f5246cb7bc302745"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 36
    sha256 cellar: :any,                 arm64_sonoma:   "2b4c9c2a2b2c64b5e8ecc0dd2adbd98129a8c48146266e7141d90e45e05a3f9f"
    sha256 cellar: :any,                 arm64_ventura:  "3789a68953e7ef81150dc66f919d796e08c5919582bb316c4d0f1f3699d33cfa"
    sha256 cellar: :any,                 arm64_monterey: "2d70b76221190c3a1669ba95e367e07e0ec957878b8a56229537aa9a36a68dc2"
    sha256 cellar: :any,                 ventura:        "b06c8bc6322b4d0e4f6a62319559602ec322aa590c2399437eb0a055de6cfa78"
    sha256 cellar: :any,                 monterey:       "c1170b58ba8b4527733acbf6b86ebf6961035636be365eab7c3f787cfafdef42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d2d0921602a1ab47aadc36cf1545e6d6392f8adb13082f04b0d85d1a403bf7b2"
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
