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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "71095d1a5671bd9cde39c057e2d1190882fff7b7b50c86fbbb959de30aff1592"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fa9a48237ab51cb6ac9f263f24d11be3e9aafa11d6001d04504decbf4628934c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "17b00f1b7af64bdcd3ddb5c969de2bc4d18113c8a1fb6e7df5700a955b49cd31"
    sha256 cellar: :any,                 arm64_linux:       "f2c38faa90f794ef5193bcff5064d1a511eeae87e5dabb622f980da238f68db0"
    sha256 cellar: :any,                 x86_64_linux:      "bb343dde5f0cc65791616b82a13a2c4bbd6816ee59f21a169d8afaa474d0614f"
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
