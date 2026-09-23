# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT87 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
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
