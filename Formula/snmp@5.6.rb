# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/241845d24ddbbccddc9be4006c103d9ddaf3b724.tar.gz"
  version "5.6.40"
  sha256 "836bc6985113313d2a9cfc14864f9506b0c752c24cc9bf0a66454e890921b9d5"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:   "60189d00a83a033d9468b16b4317ed695f3543da02d5ccfb1939560f692c5339"
    sha256 cellar: :any, arm64_sequoia: "b92507422ff6ff323eb52e3dff8acabf4c3b6257996dfb9e592d96907ca4ccd1"
    sha256 cellar: :any, arm64_sonoma:  "82ad75b64d51c434629ebcb91f8e54eb4bc24b7bd36e8d2c0cfd644de29fc1e3"
    sha256 cellar: :any, sonoma:        "6c4edcb995fbfa785dd30e8e0d52da0db2953401cf64d5c23e4300b5a4768578"
    sha256 cellar: :any, arm64_linux:   "4c69ca43812820b7352ff41d88209c16586e66f24526ad036bc3f691d9a3054b"
    sha256 cellar: :any, x86_64_linux:  "9a56aa7b346c04712b416880430ff5c487ed9eb5f996f594b1bbf4b210f1039e"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
