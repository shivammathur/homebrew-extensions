# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    manifest_sha256 "aea356d752793f4d9443997e3c2294e6a70e0945a5428b1e148a922c5f5ea465"
    sha256 cellar: :any, arm64_golden_gate: "f7f0e0dbe3fdb61d8e6abd51bfe0591db09dbe54453f4826304afd72fdc38d84"
    sha256 cellar: :any, arm64_tahoe:       "f17bd9614c1f31d32efa2f3574422c507d35d1c7fb20433772c388aa56ac3e8b"
    sha256 cellar: :any, arm64_sequoia:     "6140f48eb68f84aa958f57c4be0636eb58ecb56529245605a481c367f46be385"
    sha256 cellar: :any, arm64_linux:       "d8123cdc7b498b7c57e077d2ee5baff695ac62fcf61cbb0b8ddef4384b82c9d9"
    sha256 cellar: :any, x86_64_linux:      "94534835ad7aaae4c1a76f3d4ee6f341ccec119014b804c891645d2b16712371"
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
