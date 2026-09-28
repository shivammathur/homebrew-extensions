# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "3ae3c0cda928e8bc281e8d085e872ee3733c1dc01601c25b62233f1e602c61ee"
    sha256 cellar: :any, arm64_tahoe:       "51ee508923ac029deb67b2c0952daa6f76ed1286c2a3e56d00522fbeb0a277e9"
    sha256 cellar: :any, arm64_sequoia:     "767156d9e11628fe1621a0972568b5b2844d72eae777510c1d6d8310f81d3892"
    sha256 cellar: :any, arm64_linux:       "c67641250116879a2a55694eb41bb471d8aa992f24465163f06ef40fd11c79ad"
    sha256 cellar: :any, x86_64_linux:      "b7917147e151697b6ad96921d411cb2fd00b4bf5412b86673081bb4ab85a5b22"
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
