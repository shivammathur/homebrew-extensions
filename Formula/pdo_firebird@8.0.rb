# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5f8af80e6bdfe5d80880abccc4e7cb415c26ca42.tar.gz"
  version "8.0.30"
  sha256 "75a276a0a65cb6ad4dfab2db6fa0719601b593bfa99fd1936105952465e4e111"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "a27191e4167278f99c06e1c35efcfcc469ea2f5cb88d71c55f4efd2999c40860"
    sha256 cellar: :any, arm64_tahoe:       "9abe0c6f2cbcaf10af3004370ca0fc3d180f189b3e68423d1173ff17c8a4a728"
    sha256 cellar: :any, arm64_sequoia:     "4562912df5116d9fe0277c6f83439f5c9ef7a18b14a55fdb303eeb69ad6f5b9c"
    sha256 cellar: :any, arm64_linux:       "be1846bbd636a5bb525da9bc8c801a31d29f575a284ac09969a91aa6c63fc7bd"
    sha256 cellar: :any, x86_64_linux:      "7fba1460ae9755c1c51d6c56f611850f6f35f41e030ed82d395301cdea9c36a7"
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
