# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c8bf06235fe7fd4fa747bce70f7824a03823a6fc.tar.gz"
  version "7.1.33"
  sha256 "edea2c9b62a4cfeecb8fe0e377a2c64553463b195db251385b000f32645e343b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "a3d62f43d056095200b86648f3afd6ed3a8fdf5b86a69f0fd95b48df41ef5aa5"
    sha256 cellar: :any, arm64_sequoia: "a5cf09dd5838a7937a2db0d93af54d6c6b20be9192e4d3d73a8035e5d7cbca1e"
    sha256 cellar: :any, arm64_sonoma:  "311bd9e929083c3bac83b42f8e77de3823da584052ea6acd5878702b743592e3"
    sha256 cellar: :any, sonoma:        "fed75328daab3b668d8fc23f726ae93764ec93d68eb6b4deeab971a3434009e2"
    sha256 cellar: :any, arm64_linux:   "8dff3610890743273c7edc3d439f3c29d8534c2bf82c9782c448239ddc41311f"
    sha256 cellar: :any, x86_64_linux:  "4bd760c3fba2a43d10c887f6d70265eb8bf8fd5d7022872fc95b8c45435dd9f0"
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
