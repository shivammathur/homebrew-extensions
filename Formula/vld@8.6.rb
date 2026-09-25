# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT86 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  revision 1
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "c07d6f6f7402801802cf663678cef46c2deb083901237432d085aa28f240e0af"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "4d80cfdfc9b2cdd1a8feb2181bc4e9bd42283b0b3465d4a3cd6fc4d759c2fe6e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7c172d3f46fc3561b585fbf1928ea539ea9514c2c08c638534c1c12cb7e1055c"
    sha256 cellar: :any,                 arm64_linux:       "845d6d511bafe8e60d20fbe144e685e3493698f4263aa60fa14423c3587d8816"
    sha256 cellar: :any,                 x86_64_linux:      "41e06dcb2e6d7bc6636f3221281d41d4edd0eb250298eeb0381e1a6d091ef5aa"
  end

  def install
    inreplace "srm_oparray.c", '{ "DECLARE_ATTRIBUTED_CONST", ALL_USED },', <<~EOS.chomp
      { "DECLARE_ATTRIBUTED_CONST", ALL_USED },
      { "TYPE_ASSERT", ALL_USED },
      { "CALLABLE_CONVERT_PARTIAL", ALL_USED },
      { "SEND_PLACEHOLDER", OP2_USED },
    EOS
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end

  test do
    (testpath/"partial.php").write <<~PHP
      <?php
      function add(int $a, int $b): int { return $a + $b; }
      $inc = add(?, 1);
      $values = array_map(add(?, 1), [1, 2, 3]);
      if ($inc(5) !== 6 || $values !== [2, 3, 4]) { exit(1); }
      echo "partial application OK\n";
    PHP
    output = shell_output("#{formula_opt_bin(php_formula)}/php -n -d extension=#{prefix}/vld.so " \
                          "-d vld.active=1 -d vld.execute=1 #{testpath}/partial.php 2>&1")
    assert_match "partial application OK", output
    assert_match "TYPE_ASSERT", output
    assert_match "CALLABLE_CONVERT_PARTIAL", output
    assert_match "SEND_PLACEHOLDER", output
  end
end
