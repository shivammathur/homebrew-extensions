# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/241845d24ddbbccddc9be4006c103d9ddaf3b724.tar.gz"
  version "5.6.40"
  sha256 "836bc6985113313d2a9cfc14864f9506b0c752c24cc9bf0a66454e890921b9d5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:   "475c4a430e93d1e5baed38b21d54dcb15a489c57fcc7d4074674ab84b31111d9"
    sha256 cellar: :any, arm64_sequoia: "0ab7f49844a676dedccb1f7f6d3c436762e0ba3a2b537c6bbe26e090f22819bd"
    sha256 cellar: :any, arm64_sonoma:  "432cbe6f493cf37f461c9f9d8d6b9dcdb3443e0508eceb686677d542fe69df8c"
    sha256 cellar: :any, sonoma:        "fa06bbff911fa87a817992da2c7c60821d3f37e2cc66520f399f89282bb1f662"
    sha256 cellar: :any, arm64_linux:   "e178a4e9b6f55f18c4426401fe7dbff7d2751fd27239ce313e97f5ddfebc3afd"
    sha256 cellar: :any, x86_64_linux:  "72c117ed1a966e611c959a1c33378bfb24828ebde566aa93da710835e4d1e7af"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
