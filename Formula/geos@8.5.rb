# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT85 < AbstractPhpExtension
  init
  desc "GEOS PHP extension"
  homepage "https://gitea.osgeo.org/geos/php-geos"
  url "https://gitea.osgeo.org/geos/php-geos/archive/889e2b1d9aa6f82995db4dab6891f48c3bacfb59.tar.gz"
  sha256 "fd6a8bb62f9e2c16a2476de87ac26dc069ab6ebfecc585928d2b8b59177c2afc"
  version "1.0.0"
  head "https://gitea.osgeo.org/geos/php-geos.git", branch: "master"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "302529ae648658750297ba9a0af4fa0d5b465f018271de277f93db96641d2767"
    sha256 cellar: :any, arm64_tahoe:       "837a39da5a1e9388060fd939a6f6961534d52073ab0aad7153d53a605baa7f42"
    sha256 cellar: :any, arm64_sequoia:     "967ff2d6230383f1dc02e4f76635b9d4a6970aea4bd61faf2f72c95729a8ca53"
    sha256 cellar: :any, arm64_linux:       "763b3b00355369768b15d80fbe32a072e196cb56163650c7c1e5ce80a87d72bc"
    sha256 cellar: :any, x86_64_linux:      "17ae7e7f4cb424d2c3f7df310b4147340c12bf6f1b1a0ece7ffb1869399d971f"
  end

  depends_on "geos"

  def install
    inreplace "php_geos.h", '#define PHP_GEOS_VERSION "0.0"', "#define PHP_GEOS_VERSION \"#{version}\""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-geos",
                          "--with-geos-config=#{Utils::Path.formula_opt_bin("geos")}/geos-config"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end

  test do
    (testpath/"geos.php").write <<~PHP
      <?php
      $reader = new GEOSWKTReader();
      $polygon = $reader->read('POLYGON ((0 0, 2 0, 2 2, 0 2, 0 0))');
      $point = $reader->read('POINT (1 1)');
      $writer = new GEOSWKBWriter();
      $wkbReader = new GEOSWKBReader();
      if (phpversion('geos') !== '#{version}' || !GEOSVersion()
          || $polygon->area() != 4 || !$polygon->contains($point)
          || !$reader->read((string) $polygon)->equals($polygon)
          || !$wkbReader->read($writer->write($polygon))->equals($polygon)
          || abs($point->buffer(1, array('quad_segs' => '1'))->area() - 2) > 0.000001) {
          exit(1);
      }
      try {
          $reader->read('INVALID');
          exit(1);
      } catch (Exception $e) {
          echo "GEOS OK";
      }
    PHP
    assert_equal "GEOS OK", shell_output("#{formula_opt_bin(php_formula)}/php -n " \
                                         "-d extension=#{prefix}/geos.so #{testpath}/geos.php")
  end
end
