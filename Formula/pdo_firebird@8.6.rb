# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4923c6079e5b09d3e48e8499ff62348fd56e3a9d.tar.gz?commit=4923c6079e5b09d3e48e8499ff62348fd56e3a9d"
  version "8.6.0"
  sha256 "4fd88a6662bb1b9c2416cbed1850756d7454d6ef8971bcbf4f74243e1fbc80d8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any, arm64_tahoe:   "24a092ca06b90c23d3a8eb4e903616e0222a57e00ecdfe4368cea3f2843975ca"
    sha256 cellar: :any, arm64_sequoia: "56feb4ade5d9c837c00cfd4e1177f3dd8b41123279c5a1c6a047348f96763516"
    sha256 cellar: :any, arm64_sonoma:  "1549e8f19445186502102ee4011ea8c009c5dbd59c37b4bee462d623965fa30a"
    sha256 cellar: :any, sonoma:        "1e0ba197caaf600ab1377d1faeffbffd2251fbe1db5cd3e96e4911a0e2815321"
    sha256 cellar: :any, arm64_linux:   "ac7cab3b26eb1d0f63fac50d2a435362c697edc6139b11e70c9ab051569597e0"
    sha256 cellar: :any, x86_64_linux:  "a7bb05e4a1040d44f73f71f2b9409b95d42702437d40acdc1b195d741a529765"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
