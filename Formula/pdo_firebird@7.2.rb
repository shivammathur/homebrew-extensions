# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ff94139aa2f0383dae4da1d40fcf726b27a31.tar.gz"
  version "7.2.34"
  sha256 "cbf4d0b35b53b32b303b7e7ec171acc097094534b1e068b2c66abfce6008c4c0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "5a7e489db07dddf4d1441fbb8128265e75b8f30194b0c55a4ac7e6fdc8c63ad6"
    sha256 cellar: :any, arm64_sequoia: "3b73a3ed2e1ab9dafb841db05b0b862b334a32699efb2811849a2796e076c2c0"
    sha256 cellar: :any, arm64_sonoma:  "5b553cc6dd2050de074cd9781e61bdf03f62a759b5526278d8a9dcf7c552f0db"
    sha256 cellar: :any, sonoma:        "45f220363f61341c586a4603a12bdea3df06d02bc9799e0c7561514b6bf4dc92"
    sha256 cellar: :any, arm64_linux:   "dba1b1684630437e35605f442762c0ee9b98986dd6b123d24a4086c6359b2d4c"
    sha256 cellar: :any, x86_64_linux:  "3f5062e895bce2bb04445d9b2b5cca0f7ba678a5dc8eb872c7fa69afa7a91af5"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
