# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b39d5b8abd8dcd20feb0f734ef061a54f8bbd134.tar.gz"
  version "7.2.34"
  sha256 "5f20df8c8514e84951eebad321abee448b00c5eaff6de7f304f3e760140bc578"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "8a5ecbcf20f657c0b67ba6184cf8a78af380bd5718d13bbfb5440128c38b0e8b"
    sha256 cellar: :any, arm64_tahoe:       "8e34db918b291fa557173675c4b76700b93d93ab654e60ab8614a3cab377e23f"
    sha256 cellar: :any, arm64_sequoia:     "541b1f9bf9a6a64d0023842917e972d082c208a77e082b47a3cbb2420f94cf97"
    sha256 cellar: :any, arm64_linux:       "723f505f2a468af4bd019e5d745269d68a9328bf64446bfda78c637ca7618047"
    sha256 cellar: :any, x86_64_linux:      "1bbba4b71fb7983d91f30478c37db3a3a05afc213f366a0861d4fbfad1a2afce"
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
