# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f4457d3e8b14e8fd31f70dde5b19e6799fe71538.tar.gz"
  version "7.2.34"
  sha256 "2beaaef99d934c31390a83e51dd61f981004fca474aa4655573292409ce83ca4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "825f85d3565cd2221eb81cb6d0a0a5f2bcd0da8ec9eda85e2e9a43a8428b3a27"
    sha256 cellar: :any, arm64_tahoe:       "1c5cbb8aa2c2427502d5702c1910cb1557755c65f6b54c719e666fd278799a38"
    sha256 cellar: :any, arm64_sequoia:     "daee7838b55e3fd3761500f1980c02e32fae6bf939132e49c788cff6324d19c1"
    sha256 cellar: :any, arm64_linux:       "986068e78ca1abf8caac1b83ba4e32f4f76e0d310942aea80181765875642ad8"
    sha256 cellar: :any, x86_64_linux:      "615ca8829f83b7467dd687f368548610771237a63c642b3e2a120740f4d4a81b"
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
