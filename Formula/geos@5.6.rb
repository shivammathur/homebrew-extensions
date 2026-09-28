# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT56 < AbstractPhpExtension
  init
  desc "GEOS PHP extension"
  homepage "https://gitea.osgeo.org/geos/php-geos"
  url "https://gitea.osgeo.org/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "5f3885b764fe20ecf8f577c12747545ba21fef5f9af09b4c8447d39d7fd7f7c8"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "82a3b2664ef2e2cd83159adc56e127201e68433ce9824468cf692ba17f4aaa75"
    sha256 cellar: :any, arm64_tahoe:       "0503177ac40f23987de66518bd191408720dbc79b727036ae66bf3cc886b4566"
    sha256 cellar: :any, arm64_sequoia:     "7682c2630782c1d05dcb602011e0e1c6b78307561d8520056384ae62e9e59999"
    sha256 cellar: :any, arm64_linux:       "49f0bdc298330b62d856ed1f3ac944d527286c8844383ea214e09a0901123b4e"
    sha256 cellar: :any, x86_64_linux:      "673b4c64c937cf1ea15eff170f953c1c4ac8eafc5f82f6880c4671f7a8f8190c"
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
