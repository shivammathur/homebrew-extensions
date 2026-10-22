# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2e922830b542a067a306870dffd20040f34fb05c.tar.gz"
  version "5.6.40"
  sha256 "04c58a4a21c99f3a8df74c37141231691497ebf50a5dce3479f168de7b6f3a5e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "5d337128ba4552f682e5586a923ba8b1ffd306be59f104b0b3d16492ca4d00e0"
    sha256 cellar: :any, arm64_tahoe:       "d83eaa912df0ec885097001e90f683174e1394ec336c62bc59a04481f142aeca"
    sha256 cellar: :any, arm64_sequoia:     "662a349412b2f9df7c214c24e752afe26d7952c863584345662a52328ae9c0c4"
    sha256 cellar: :any, arm64_linux:       "e7cdca81566f2fc03485b42326e588514ae2cb952ef851edc378f3a349b1dd53"
    sha256 cellar: :any, x86_64_linux:      "b36f84446ead8515c590a4003154dc9d9739158b1253251020d4c87a3fe3560f"
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
