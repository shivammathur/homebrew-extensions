# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "11ac3d6f3f96e810baaabf4b3f0b40bec8c3a41c5ca5909962d31d34134c1e95"
    sha256 cellar: :any, arm64_tahoe:       "d06d374fb32456dcd67db9d775c40fcf72dd177f04526a72c3042e2479785bda"
    sha256 cellar: :any, arm64_sequoia:     "8a33ff46419b37d20bec06d7fdcac5c90d8d99e2901ee4d33d3af66fd7a49467"
    sha256 cellar: :any, arm64_linux:       "2014d4181ea6cfd8206e2819638212a7f1a7ea5672e016710eca6a16f05e863a"
    sha256 cellar: :any, x86_64_linux:      "37ea273f321902368ef3e055f6ca2ddf3a67b6ecbc3099388f56939d69436ffc"
  end

  depends_on "geos"

  def install
    inreplace "php_geos.h", '#define PHP_GEOS_VERSION "0.0"', "#define PHP_GEOS_VERSION \"#{version}\""
    # PHP 8.6 removed these aliases.
    inreplace "geos.c" do |s|
      s.gsub! "zval_dtor", "zval_ptr_dtor_nogc"
      s.gsub! "XtOffsetOf", "offsetof"
    end
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
