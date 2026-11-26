# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    manifest_sha256 "edbe631d525e1099144907e40757824bc140a33ca5c184237d86f655a628e38d"
    sha256 cellar: :any, arm64_golden_gate: "051c69607c6e56ac65b82072940b4cd930986529f70513c6e89abd82bd18a049"
    sha256 cellar: :any, arm64_tahoe:       "17ad27452f9cb2272d744bb120d9395841181b21da9ba6e7a822f869132c7703"
    sha256 cellar: :any, arm64_sequoia:     "1de8295f493fc47a95bbaee9141761f20abfe26e71f0661040cc6b66dec9e4ad"
    sha256 cellar: :any, arm64_linux:       "a46e4ca2eb19664ebb6012b3c6c5fd052ed72ac05b8579dbac86d14099c5fe55"
    sha256 cellar: :any, x86_64_linux:      "e2f6b44478df42df95899e5641d446a0a375e3853f37703e18d75dbe9650ff83"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
