# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    manifest_sha256 "34ae638938e9ed67b79ff01b3f5293ea2ef0bae78e131e4d5bcae2cca32e2452"
    sha256 cellar: :any, arm64_golden_gate: "6a225178467f870dcebe672a568838fe0ea11359a0e233c97ed9c61884eea517"
    sha256 cellar: :any, arm64_tahoe:       "31d08f50255988fc4f07cfb519fd476b40b74a51f69cb3261c2a5b3c63cbfe1e"
    sha256 cellar: :any, arm64_sequoia:     "154adbb721eb0d62d6fe8e34556f005ca535f9182e63a3324a581d222232164b"
    sha256 cellar: :any, arm64_linux:       "952110a06bd3cd5b6013e84a2654c74f4bf03155794b4fafae71c483045abd99"
    sha256 cellar: :any, x86_64_linux:      "2c29aaaa95155bd32e3c82f4b8eb3140ccc6872b86c67a09f1e54edfe6861b1c"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
